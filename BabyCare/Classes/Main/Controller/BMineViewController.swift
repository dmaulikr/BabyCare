//
//  BMineViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/21.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BMineViewController: JBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        label.text = "我的"
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.blue
    }


}
