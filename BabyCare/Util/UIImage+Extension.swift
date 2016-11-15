//
//  UIImage+Extension.swift
//  Poems
//
//  Created by Neo on 16/10/31.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

extension UIImage{
    class func imageFrom(color:UIColor) -> UIImage?{

        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)

        let content = UIGraphicsGetCurrentContext()
        content?.setFillColor(color.cgColor)
        content?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
