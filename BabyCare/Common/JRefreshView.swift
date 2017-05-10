//
//  JRefreshView.swift
//  Poems
//
//  Created by Neo on 2016/11/3.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

enum RefreshState {
    case pulling
    case normal
    case loading
}

protocol JRefreshProtocol {
    
    func pullRefreshDidTrigger(refreshView: JRefreshView)
    
    func pullRefreshLoading(refreshView: JRefreshView) -> Bool
}

class JRefreshView: UIView {
    let delegate: JRefreshProtocol

    var arrowImageView: UIImageView?
    var activeImageView: UIImageView?
    var state :RefreshState = .normal
    
    init(delegate: JRefreshProtocol, frame:CGRect) {
        self.delegate = delegate
        
        super.init(frame: frame)
//        arrowImageView = UIImageView.init(frame: CGRect(x: (frame.size.width-11)/2, y: (frame.size.height-16)/2, width: 1, height: 16))
//        self.addSubview(arrowImageView)
//        
//        activeImageView = UIImageView.init(frame: <#T##CGRect#>)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshScrollViewDidScroll(scrollView: UIScrollView) {
        if state == .loading {
            var offset: CGFloat = max(scrollView.contentOffset.y * -1, 0)
            offset = min(offset, 60)
            scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0)
        } else if scrollView.isDragging{

            let loading = delegate.pullRefreshLoading(refreshView: self)
            if state == .pulling && scrollView.contentOffset.y > -65 && scrollView.contentOffset.y < 0 && !loading {
                state = .normal
            } else if state == .normal && scrollView.contentOffset.y < -65 && !loading{
                state = .pulling
            }
            if scrollView.contentInset.top != 0 {
                scrollView.contentInset = UIEdgeInsets.zero
            }
        }
    }
    
    func refreshScrollViewDidEndDragging(scrollView: UIScrollView) {
        let loading = delegate.pullRefreshLoading(refreshView: self)
        if scrollView.contentOffset.y <= -65 && !loading {
            UIView.animate(withDuration: 0.25, animations: { 
                scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
            })
            delegate.pullRefreshDidTrigger(refreshView: self)
            state = .loading
        }
    }
    
    func refreshViewDidFinishedLoading(scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) { 
            scrollView.contentInset = UIEdgeInsets.zero
        }
        state = .normal
    }
}
