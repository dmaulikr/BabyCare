//
//  JLoadMoreTableViewCell.swift
//  Poems
//
//  Created by Neo on 2016/11/4.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

enum LoadMoreCellState {
    case normal
    case loading
    case failed
}

protocol JLoadMoreTableViewCellDelegate {
    
    func startLoading(cell: JLoadMoreTableViewCell)
    func isLoading(cell: JLoadMoreTableViewCell) -> Bool
}

class JLoadMoreTableViewCell: UITableViewCell {
    var delegate: JLoadMoreTableViewCellDelegate?
    var state: LoadMoreCellState = .normal{
        didSet{
            // do something
        }
    }
    
    let cellHeight: CGFloat = 44.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y - scrollView.contentInset.bottom >= scrollView.contentSize.height - scrollView.height {
            if state == .normal {
                state = .loading
            }
        }
    }
    
    func scorllViewDidEndDragging(scrollView: UIScrollView) {
        if scrollView.contentOffset.y - scrollView.contentInset.bottom >= scrollView.contentSize.height - scrollView.height {
            if state == .normal {
                state = .loading
            }
        }
        if state == .loading && !(delegate?.isLoading(cell: self))! {
            delegate?.startLoading(cell: self)
        }
    }
    
    func startLoading() {
        state = .loading
        delegate?.startLoading(cell: self)
    }
}
