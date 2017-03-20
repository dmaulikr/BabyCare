//
//  Entity.swift
//  BabyCare
//
//  Created by Neo on 2016/11/17.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation

class Entity: NSObject, NSCoding{
    
    override required init() {}
    
    var mirror: Mirror{
        get{
            return Mirror(reflecting: self)
        }
    }
    
    // 若是复杂数据类型 需要指定 key：value 其中key为属性名称 value 为对应的key所对应的数据类型--class name string eg：Entity
    var config: [String: String]{
        get{
            return [:]
        }
    }

    func entity(with:Dictionary<String, Any>){
        for case let (label?, _) in mirror.children {
            let dicValue = with[label.lowercased()]
            if let _ = dicValue {
                if dicValue is Int || dicValue is String || dicValue is Float {
                    self.setValue(dicValue, forKey: label)
                }else{
                    if dicValue is Array<Any> {
                        let array = dicValue as! Array<Any>
                        self.setValue(self.recursionArray(with: array,key: label), forKey: label)
                    }
                    if dicValue is Dictionary<String, String> {
                        let clsName = self.getClassName(propertyName: label, pure: false) 
                        let cls = NSClassFromString(clsName) as! Entity.Type

                        let tempEntity = cls.init()
                        tempEntity.entity(with: dicValue as! Dictionary<String, String>)
                        self.setValue(tempEntity, forKey: label)
                    }
                }
            }
        }
    }
    
    func recursionArray(with array:Array<Any>, key: String) -> Array<Any>{
        // 对变量类型进行判断 若错误的设置了为array 属性 则 assert
        var clsName = self.getClassName(propertyName: key, pure: true)
        if clsName.characters.count<=0 {
            clsName = self.getClassName(propertyName: key, pure: false)
        }
        var equal = false
        if clsName.contains("Array") {
            equal = true
        }
        assert(equal, "变量类型为正确设置（\(clsName) != Array)")
        
        let tempArray = NSMutableArray(array: array)
        for item in array {
            if item is Array<Any> {
                tempArray.replaceObject(at: (array as NSArray).index(of: item), with: self.recursionArray(with: item as! Array, key: key))
            }else{
                // 配置表中对应的key：value】
                let value = self.config[key]! as String
                
                if !value.isEmpty {
                    // 拼凑成完整版的类名 参考：property_getAttributes 格式 “_TtC” + 工程名字数+工程名+类名字数+类名 这样才可以反向得到一个类
                    let projectName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
                    let clsName = "_TtC" + String(projectName.characters.count) + projectName + String(value.characters.count) + value
                    
                    let a = NSClassFromString(clsName) as! Entity.Type
                    let index = (array as NSArray).index(of: item)                    
                    let tempEntity = a.init()
                    tempEntity.entity(with: item as! Dictionary<String, String>)
                    tempArray.replaceObject(at:index, with:tempEntity)
                }               
            }
        }
        return tempArray as Array
    }
    
    func getClassName(propertyName: String, pure: Bool) ->String{
        let property = class_getProperty(self.classForCoder, UnsafePointer<Int8>(propertyName))
        var propertyString = String(cString: property_getAttributes(property)).components(separatedBy: "\"")[1]
        if !pure {
            // 针对自定义类型 而言 会有一堆修饰字符
            return propertyString
        }
        let projectName = Bundle.main.infoDictionary?["CFBundleExecutable"]

        let range = (propertyString as NSString).range(of: projectName as! String)
        if range.length>0 {
            propertyString = (propertyString as NSString).substring(from: range.location+range.length)
        }
        let set  = CharacterSet(charactersIn: "0123456789")        
        return propertyString.trimmingCharacters(in: set)
    }
    
    class func entityElement(data: Dictionary<String, Any>) -> Self{
        let entity = self.init()
        entity.entity(with: data)
        return entity
    }
    
     func encode(with aCoder: NSCoder) {
        aCoder.encode(self.reserve(entity: self), forKey: "coder")
    }

    public required init?(coder aDecoder: NSCoder){
        super.init()
        self.entity(with: aDecoder.decodeObject(forKey: "coder") as! Dictionary<String, Any>)
        
    }
    
    func reserve(entity:Entity) -> Dictionary<String, Any> {
        var dic: Dictionary<String,Any> = [:]

        for case let (label?, value) in mirror.children {            
            let clsName = self.getClassName(propertyName: label, pure: true)
            if clsName.contains("Array"){
                // 配置表中对应的类型string----value
                var tempArray = [Dictionary<String, Any>]()
                for item in value as! Array<Entity> {
                    let tempDic = item.reserve(entity: item)
                    tempArray.append(tempDic)
                }
                dic[label] = tempArray
            }else if clsName.contains("Entity") {
                    // 自定义类型
                let tempDic =  (value as! Entity).reserve(entity: value as! Entity)
                dic[label] = tempDic
            }else{
                dic[label] = value
            }
        }        
        return dic
    }
}
