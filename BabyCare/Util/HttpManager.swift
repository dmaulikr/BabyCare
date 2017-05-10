//
//  HttpManager.swift
//  Poems
//
//  Created by Neo on 16/9/29.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation
import Alamofire

class HttpManager{

    class func requestAsynchronous(url:String, parameters:Dictionary<String, String>,completion:@escaping (_ data:AnyObject?) -> ()) {

    #if DEBUG
        var string = "?softversion=\(Util.appVersion())&systype=ios&sysversion=\(Util.systemVersion())"
        
        for key in parameters.keys {            
            string = string + "&" + key + "=" + parameters[key]!
        }
        print(HostName + url + string)
        
    #endif
        
        Alamofire.request((HostName+url), method:.post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let result = response.result.value as AnyObject
                
                completion(result)
            } else {
                print(response.result.error.debugDescription)
            }
        }
    }
}

