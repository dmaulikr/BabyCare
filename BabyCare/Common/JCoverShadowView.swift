//
//  JCoverShadowView.swift
//  BabyCare
//
//  Created by Neo on 2017/3/20.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

class JCoverShadowView: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 0.4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
