//
//  JBreastMilkDataModel.swift
//  BabyCare
//
//  Created by Neo on 2016/12/14.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JBreastMilkEntity: Entity {
    var createTime: String?
    var id: String?
    var babyId: String?
    var left: String?
    var right: String?
}

class JBreastMilkDataModel: JDataModel {
    
    override var limitedCount: Int{
        return 15
    }
    
    var babyId: String?
    
    
    override func requestUrl() -> String {
        return "breastmilk"
    }
    override func param() -> Dictionary<String, String> {
        return ["babyid": self.babyId!]
    }
    
    override func cacheKey() -> String? {
        return "JBreastMilkDataModel"
    }
    
    override func entityData(data:Dictionary<String, Any>) -> Any? {
        return JBreastMilkEntity.entityElement(data: data)
    }

}
