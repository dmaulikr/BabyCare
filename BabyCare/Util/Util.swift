//
//  Util.swift
//  Poems
//
//  Created by Neo on 16/9/27.
//  Copyright © 2016年 JL. All rights reserved.
//

import Foundation
import UIKit

func PerformSelector(delay: Double,execute: @escaping ()->()){
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay){
        execute()
    }
}

class Util{
    class func getCurrentDeviceUUID() -> String{        
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    class func systemVersion() -> Float{
        return (UIDevice.current.systemVersion as NSString).floatValue
    }
    
    class func screenWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
    
    class func screenHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
    
    class func appVersion() -> String{
        let ver : Any? = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        return ver as! String
    }
    
    class func barButtonItem(image:UIImage, target:Any, action:Selector, imageEdgeInsets:UIEdgeInsets)->UIBarButtonItem{
        let button = Util.barButton(title: nil, target: target, action: action)
        button.imageEdgeInsets = imageEdgeInsets
        button.setImage(image, for: .normal)
        button.width = image.size.width+10
        button.height = 44
        button.isExclusiveTouch = true
        return UIBarButtonItem(customView: button)
    }
    
    private class func barButton(title:String?, target:Any, action:Selector)->UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState.normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
