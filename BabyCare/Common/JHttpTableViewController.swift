//
//  JHttpTableViewController.swift
//  Poems
//
//  Created by Neo on 16/11/1.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JHttpTableViewController: JBaseViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    
    var dataModel = JDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight]
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        
        dataModel = self.createDataModel()
        if let _ = dataModel.data {
            tableView.reloadData()
        }
        self.perform(#selector(loadData), with: nil, afterDelay: 0.1)
    }
    
    func createDataModel() -> JDataModel {
        return JDataModel()
    }

    func loadData(){
        dataModel.loadData(start: { 
            
            }, sucess: { (resultDataModel) in
                self.dataModel = resultDataModel
                self.loadFinished()
            }) { (error) in
                
                self.loadFailed()
        }
    }
    
    func loadFinished() {
        tableView.reloadData()
    }
    
    func loadFailed() {
        
    }
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
