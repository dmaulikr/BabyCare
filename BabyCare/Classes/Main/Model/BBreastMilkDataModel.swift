//
//  BBreastMilkDataModel.swift
//  BabyCare
//
//  Created by Neo on 2017/3/20.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

class BBreastMilkEntity: Entity {
    var createTime: String?
    var id: String?
    var babyId: String?
    var left: String?
    var right: String?
}

class BBreastMilkDataModel: JDataModel {
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
        return BBreastMilkEntity.entityElement(data: data)
    }
}
