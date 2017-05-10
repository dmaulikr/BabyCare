//
//  BUser.swift
//  BabyCare
//
//  Created by Neo on 2016/11/17.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit


class BUser: Entity {
    
    var uid: String?
    var avatar: String?
    var nickname: String?
    var babies: Array<Any>?
    
    override var config:[String:String] {
        get{
           return ["babies":"BBaby"]
        }
    }
    
}

// MARK: ------

class BBaby: Entity {
    var bid: String?
    var babyname: String?
}
