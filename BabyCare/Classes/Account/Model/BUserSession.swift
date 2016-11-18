//
//  BUserSession.swift
//  BabyCare
//
//  Created by Neo on 2016/11/19.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation

class BUserSession{
    
    static let instance = BUserSession()
    
    // 私有化构造器 配合static 创造单例
    private init(){}
    
    var user: BUser?
    
    
    
}
