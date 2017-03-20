//
//  BMilkViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/12/11.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BMilkViewController: JPullRefreshLoadMoreViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = .flexibleHeight
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "牛奶"
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.purple
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
    }

}
