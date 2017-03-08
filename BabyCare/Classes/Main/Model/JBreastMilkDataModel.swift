//
//  JBreastMilkDataModel.swift
//  BabyCare
//
//  Created by Neo on 2016/12/14.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JBreastMilkEntity: Entity {
    
}

class JBreastMilkDataModel: JDataModel {
    
    override var limitedCount: Int{
        return 20
    }
    
    override func requestUrl() -> String {
        return ""
    }
    override func param() -> Dictionary<String, String> {
        return [:]
    }
    
    override func cacheKey() -> String? {
        return ""
    }
    
    override func entityData(data:Dictionary<String, Any>) -> Any? {
        return JBreastMilkEntity.entityElement(data: data)
    }

}
