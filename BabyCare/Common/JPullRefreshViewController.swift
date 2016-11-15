//
//  JPullRefreshViewController.swift
//  Poems
//
//  Created by Neo on 2016/11/3.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JPullRefreshViewController: JHttpTableViewController, JRefreshProtocol {

    var refreshView: JRefreshView?
    var isRefresh = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView = JRefreshView(delegate: self, frame: CGRect(x: 0, y: -60, width: self.view.width, height: 60))
        self.tableView.addSubview(refreshView!)

    }
    
    func refreshData() {
        self.dataModel.reload = true
        self.loadData()
    }

    func pullRefreshDidTrigger(refreshView: JRefreshView) {
        self.refreshData()
    }
    
    func pullRefreshLoading(refreshView: JRefreshView) -> Bool {
        
        return self.dataModel.loading
    }
    
// MARK: - scrollview delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.refreshView?.refreshScrollViewDidScroll(scrollView: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.refreshView?.refreshScrollViewDidEndDragging(scrollView: scrollView)
    }
    
    override func loadFinished() {
        super.loadFinished()
        refreshView?.refreshViewDidFinishedLoading(scrollView: tableView)
    }
    
    override func loadFailed() {
        super.loadFailed()
        refreshView?.refreshViewDidFinishedLoading(scrollView: tableView)
    }
    
}
