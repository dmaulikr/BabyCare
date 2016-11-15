//
//  JBaseTableViewCell.swift
//  Poems
//
//  Created by Neo on 2016/11/5.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JBaseTableViewCell: UITableViewCell {

    var separatorShow: Bool = true{
        didSet{
            separatorLineView?.isHidden = !separatorShow
        }
    }
    var customSeparatorInsets = UIEdgeInsets.zero{
        didSet{
            separatorLineView?.left = customSeparatorInsets.left
            separatorLineView?.top = self.height - customSeparatorInsets.bottom - 1
            separatorLineView?.width = self.width - customSeparatorInsets.left - customSeparatorInsets.right
        }
    }
    
    var separatorLineView: JOnePixLineView?
    
    class func cellHeight(data: AnyObject?) -> CGFloat{
        return 44
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        separatorLineView = JOnePixLineView(frame: CGRect(x: 0, y: self.height-1, width: self.width, height: 1))
        separatorLineView?.lineColor = UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 0.2)
        separatorLineView?.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        
        self.contentView.addSubview(separatorLineView!)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
