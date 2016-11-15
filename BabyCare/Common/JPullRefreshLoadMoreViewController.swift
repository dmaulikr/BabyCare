//
//  JPullRefreshLoadMoreViewController.swift
//  Poems
//
//  Created by Neo on 2016/11/4.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JPullRefreshLoadMoreViewController: JPullRefreshViewController, JLoadMoreTableViewCellDelegate {
    
    var loadMoreCell: JLoadMoreTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMoreCell = JLoadMoreTableViewCell(style: .default, reuseIdentifier: nil)
        loadMoreCell?.delegate = self
            
    }

    func startLoading(cell: JLoadMoreTableViewCell) {
        if !self.dataModel.loading && self.dataModel.canLoadMore{
            self.loadData()
        }else if loadMoreCell?.state == .loading{
            loadMoreCell?.state = .normal
        }
    }
    
    func isLoading(cell: JLoadMoreTableViewCell) -> Bool {
        return self.dataModel.loading
    }

    override func loadFinished() {
        super.loadFinished()
        loadMoreCell?.state = .normal
    }
    
    override func loadFailed() {
        super.loadFailed()
        loadMoreCell?.state = .failed
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        loadMoreCell?.scrollViewDidScroll(scrollView: scrollView)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        loadMoreCell?.scorllViewDidEndDragging(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) == loadMoreCell && loadMoreCell?.state == .failed{
            loadMoreCell?.startLoading()
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
