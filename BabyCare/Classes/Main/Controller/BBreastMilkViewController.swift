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

        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
    }
    
    override func refreshData() {
        let dataModel = self.dataModel as! JBreastMilkDataModel
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
        let dataModel: JBreastMilkDataModel = JBreastMilkDataModel()
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
        cell?.breastMilk = self.dataModel.item(index: indexPath.row) as! JBreastMilkEntity?
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return (self.loadMoreCell?.cellHeight)!
        }else{
            return BBreastMilkTableViewCell.cellHeightWith(data: nil)
        }
    }
}
