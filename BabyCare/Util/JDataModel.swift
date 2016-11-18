//
//  JDataModel.swift
//  Poems
//
//  Created by Neo on 16/10/28.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation

class JDataModel{
    
    var code: Int = 10001
    var msg: String = ""
    var canLoadMore: Bool = false
    var loading: Bool = false

    var data: AnyObject? = nil
    var itemCount: Int = 0
    
    var reload: Bool = true{
        didSet{
            if reload {
                self.page = 0    
            }
        }
    }
    var page = 0
    let limitedCount = 20
    
    
    func requestUrl() -> String {
        return ""
    }
    
    func item(index: Int) -> AnyObject? {
        if self.data is Array<AnyObject> {
            let array = self.data as! Array<AnyObject>
            return array[index]
        }
        print("错误的取值")
        return nil
    }
    
    func param() -> Dictionary<String, String> {
        return [:]
    }
    
    private func resultParam() -> Dictionary<String, String>{
        var dic = self.param()
        dic["page"] = String(self.page)
        dic["pagesize"] = String(limitedCount)
        return dic
    } 
    
    func cacheKey() -> String? {
        return ""
    }
    
    func entityData(data:Dictionary<String, Any>) -> Any? {
        return Entity.entityElement(data: data)
    }
    
    func loadData(start:() -> (),sucess:@escaping (_ dataModel: JDataModel) -> (), failed:(_ error: Error) -> ()){
        if !loading {
            start()
            loading = true
            HttpManager.requestAsynchronous(url: self.requestUrl(), parameters: self.resultParam()) { data in
                sucess(self.parseData(data: data as! Dictionary<String, Any>?))
                self.loading = false
            }
        }
    }
    
    func parseData(data:Dictionary<String,Any>?) -> JDataModel {
        self.code = data?["code"] as! Int
        self.msg = data?["msg"] as! String
        if self.code != 0 {
            return self
        }
        if let ret = data?["data"] {
            if ret is Array<AnyObject>{
                var retArray = [AnyObject]()
                
                if retArray.count >= limitedCount {
                    canLoadMore = true
                }else{
                    canLoadMore = false
                }
                
                var array = self.data as! [AnyObject]
                
                for i in 0 ..< (ret as! Array<AnyObject>).count{
//                    retArray.replaceObject(at: i, with: self.entityData(data: retArray[i]))
                    retArray[i] = self.entityData(data: (ret as! Array<Any>)[i] as! Dictionary<String, Any>) as AnyObject
                }
                if !reload {
                    array += retArray
                    self.data = array as AnyObject?
                }else{
                    self.data = retArray as AnyObject?
                }
            }else{
                self.data = self.entityData(data: ret as! Dictionary<String, Any>) as AnyObject
            }
            itemCount = (self.data?.count)!
            reload = false
            JCacheManager.sharedInstance().setCache(self.data as! NSCoding, forKey: self.cacheKey())
        }
        return self
    }
    
    func loadCache() {
        if let cacheKey = self.cacheKey() {
            if let _ = JCacheManager.sharedInstance().cache(forKey: cacheKey){
                self.data = JCacheManager.sharedInstance().cache(forKey: cacheKey) as AnyObject
                if self.data is Array<AnyObject>{
                    itemCount = (self.data?.count)!
                }
            }
        }
    }
    
}
