//
//  BUserSession.swift
//  BabyCare
//
//  Created by Neo on 2016/11/19.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation

let userCacheKey = "userCacheKey"

let USER_SESSION_CHANGED = "user_session_changed"

class BUserSession{
    
    static let instance = BUserSession()
    
    // 私有化构造器 配合static 创造单例
    private init(){
        self.user = JCacheManager.sharedInstance().cache(forKey: userCacheKey) as! BUser?
    }
    
    var sessionValid: Bool{
        get{
            if user == nil {
                return false
            }
            return !(self.user?.uid?.isEmpty)!
        }
    }
    
    var user: BUser?{
        didSet{
            JCacheManager.sharedInstance().setCache(user, forKey: userCacheKey)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_SESSION_CHANGED), object: nil)
        }
    }
    
    // update
    func updateUser(with data: Dictionary<String, Any>){
        self.user = BUser.entityElement(data: data)
    }
    
    // exit
    func exitSession(){
        self.user = nil
    }
    
    func authAndExecute(execute: (Bool) -> Void) {
        if self.sessionValid {
            execute(true)
        }else{
            
        }
    }
}
