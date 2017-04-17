//
//  BBottleMilkDataModel.swift
//  BabyCare
//
//  Created by Neo on 2017/3/21.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

class BBottledMilkEntity: Entity {
    var amount: String?
    var id: String?
    var createTime: String?
    var babyId: String?
    var type: String?
}

class BBottledMilkDataModel: JDataModel {

    override var limitedCount: Int{
        return 15
    }
    
    var babyId: String?
    
    
    override func requestUrl() -> String {
        return "bottledmilk"
    }
    override func param() -> Dictionary<String, String> {
        return ["babyid": self.babyId ?? ""]
    }
    
    override func cacheKey() -> String? {
        return "BBottleMilkDataModel" + self.babyId!
    }
    
    override func entityData(data:Dictionary<String, Any>) -> Any? {
        return BBottledMilkEntity.entityElement(data: data)
    }
    
}
