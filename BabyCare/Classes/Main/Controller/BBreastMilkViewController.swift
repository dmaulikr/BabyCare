//
//  BBreastMilkViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/12/11.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BBreastMilkViewController: JPullRefreshLoadMoreViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.autoresizingMask = .flexibleHeight
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 60))

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 60))
        
        let addButton = UIButton(frame: CGRect(x: (headerView.width - 40)/2.0, y: 10, width: 40, height: 40))
        addButton.cornerRadius = 20
        addButton.backgroundColor = UIColor.red
        headerView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        self.tableView.tableHeaderView = headerView
    }
    
    override func refreshData() {
        let dataModel = self.dataModel as! BBreastMilkDataModel
        dataModel.babyId = currentBaby?.bid
        super.refreshData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.dataModel.canLoadMore {
            return 2
        }
        return 1
    }
    
    override func createDataModel() -> JDataModel {
        let dataModel: BBreastMilkDataModel = BBreastMilkDataModel()
        dataModel.babyId = currentBaby?.bid
        return dataModel
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }else{
            return self.dataModel.itemCount
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return self.loadMoreCell!
        }
        let identifier = "BBreastMilkTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BBreastMilkTableViewCell
        if cell == nil {
            cell = BBreastMilkTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        if indexPath.row > 0 {
            let preEntity = self.dataModel.item(index: indexPath.row - 1) as! BBreastMilkEntity
            let preDate = Date(timeIntervalSince1970: Double(preEntity.createTime!)!)
            
            let currentEntity = self.dataModel.item(index: indexPath.row) as! BBreastMilkEntity
            let currentDate = Date(timeIntervalSince1970: Double(currentEntity.createTime!)!)
            
            let isSame = Calendar.current.isDate(preDate, inSameDayAs: currentDate)
            cell?.hideDate(hidden: isSame)
        }
        cell?.breastMilk = self.dataModel.item(index: indexPath.row) as! BBreastMilkEntity?
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return (self.loadMoreCell?.cellHeight)!
        }else{
            return BBreastMilkTableViewCell.cellHeightWith(data: nil)
        }
    }
    
    //MARK: -- xxx
    func add(button: UIButton) {
        Hud.show(content: "增加", withTime: 2)
    }
}
