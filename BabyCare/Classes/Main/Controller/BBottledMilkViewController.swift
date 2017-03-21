//
//  BMilkViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/12/11.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BBottledMilkViewController: JPullRefreshLoadMoreViewController, BBottledMilkAddViewDelegate {

    lazy var shadowView: BBottledMilkAddView = {
        let view: BBottledMilkAddView = BBottledMilkAddView(frame: Util.window().bounds) 
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: BabyChanged, object: nil)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 60))
        let addButton = UIButton(frame: CGRect(x: (headerView.width - 40)/2.0, y: 10, width: 40, height: 40))
        addButton.cornerRadius = 20
        addButton.backgroundColor = UIColor.red
        headerView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        self.tableView.tableHeaderView = headerView
        
    }
    
    override func refreshData() {
        let dataModel = self.dataModel as! BBottledMilkDataModel
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
        let dataModel: BBottledMilkDataModel = BBottledMilkDataModel()
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
        let identifier = "BBottledMilkTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BBottledMilkTableViewCell
        if cell == nil {
            cell = BBottledMilkTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        if indexPath.row > 0 {
            let preEntity = self.dataModel.item(index: indexPath.row - 1) as! BBottledMilkEntity
            let preDate = Date(timeIntervalSince1970: Double(preEntity.createTime!)!)
            
            let currentEntity = self.dataModel.item(index: indexPath.row) as! BBottledMilkEntity
            let currentDate = Date(timeIntervalSince1970: Double(currentEntity.createTime!)!)
            
            let isSame = Calendar.current.isDate(preDate, inSameDayAs: currentDate)
            cell?.hideDate(hidden: isSame)
        }
        cell?.bottledMilk = self.dataModel.item(index: indexPath.row) as! BBottledMilkEntity?
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return (self.loadMoreCell?.cellHeight)!
        }else{
            return BBottledMilkTableViewCell.cellHeightWith(data: nil)
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

    func addViewDone(amount: Int ,type: Int) {
        print(amount)
        HttpManager.requestAsynchronous(url: "bottledmilk/add", parameters: ["babyid":(currentBaby?.bid)!,"type":String(type),"amount":String(amount)]) { object in
            let code = object as! Dictionary<String,AnyObject>
            let c = code["code"]
            if Int(c as! NSNumber) == 0 {
                Hud.show(content: "添加成功", withTime: 2)
                self.refreshData()
            }
        }
        
    }
}
