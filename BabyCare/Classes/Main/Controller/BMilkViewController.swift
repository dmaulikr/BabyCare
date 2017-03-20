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
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 60))
        
        let addButton = UIButton(frame: CGRect(x: (headerView.width - 40)/2.0, y: 10, width: 40, height: 40))
        addButton.cornerRadius = 20
        addButton.backgroundColor = UIColor.red
        headerView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        self.tableView.tableHeaderView = headerView
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "牛奶"
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.purple
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
    }
    
    //MARK: -- xxx
    func add(button: UIButton) {
        Hud.show(content: "增加", withTime: 2)
    }

}
