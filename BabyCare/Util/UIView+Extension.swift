//
//  UIView+Extension.swift
//  Poems
//
//  Created by Neo on 16/9/27.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

extension UIView{
    
    // 上
    var top: CGFloat{
        get{
            return self.frame.origin.y
        }
        set(top){
            self.frame = CGRect(x: self.frame.origin.x, y: top, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    // 下
    var bottom: CGFloat{
        get{
            return self.frame.origin.y+self.frame.height
        }
        set(bottom){
            self.frame = CGRect(x: self.frame.origin.x, y: bottom-self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    
    // 左
    var left: CGFloat{
        get{
            return self.frame.origin.x
        }
        set(left){
            self.frame = CGRect(x: left, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    // 右
    var right: CGFloat{
        get{
            return self.frame.origin.x+self.frame.size.width
        }
        set(right){
            self.frame = CGRect(x: right-self.frame.size.width, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    // 宽
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set(width){
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
        }
    }
  
    // 高
    var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set(height){
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
        }
    }
    
    var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame = CGRect(x: origin.x, y: origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}
