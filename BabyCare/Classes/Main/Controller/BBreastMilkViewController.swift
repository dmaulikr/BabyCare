//
//  BBreastMilkViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/12/11.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BBreastMilkViewController: JPullRefreshLoadMoreViewController, BBreastMilkAddViewDelegate {

    lazy var shadowView: BBreastMilkAddView = {
        let view: BBreastMilkAddView = BBreastMilkAddView(frame: Util.window().bounds) 
        view.delegate = self
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainViewController?.navigationItem.rightBarButtonItem = Util.barButtonItem(title: "添加", target: self, action: #selector(add))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
    
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
        if !Util.window().subviews.contains(shadowView) {
            Util.window().addSubview(shadowView)
            shadowView.alpha = 0
        }
        shadowView.show()
    }
    
    //MARK: -- delegate
    
    func addViewDone(left: Int, right: Int) {
        
        HttpManager.requestAsynchronous(url: "breastmilk/add", parameters: ["babyid":(currentBaby?.bid)!,"left":String(left),"right":String(right)]) { object in
            let code = object as! Dictionary<String,AnyObject>
            let c = code["code"]
            if Int(c as! NSNumber) == 0 {
                Hud.show(content: "添加成功", withTime: 2)
                self.refreshData()
            }
        }
    }
}
