//
//  BMainViewController.swift
//  babycare
//
//  Created by Neo on 2016/11/15.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BMainViewController: JBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 20, y: 50, width: 100, height: 20))
        label.text = "测试"
        
        self.view.addSubview(label)
    }

}
