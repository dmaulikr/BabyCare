//
//  JMainBabiesScrollView.swift
//  BabyCare
//
//  Created by Neo on 2017/3/8.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit


class JMainBabyAvatarView: UIControl {
    
    var nameLabel: UILabel?
    
    var baby: BBaby?{
        didSet{
            nameLabel?.text = baby?.babyname
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
     self.backgroundColor = UIColor.colorWithHex(hex: "999999")   
        nameLabel = UILabel(frame: self.bounds)
        nameLabel?.font = UIFont.systemFont(ofSize: 13)
        nameLabel?.textColor = UIColor.colorWithHex(hex: "")
        nameLabel?.textAlignment = .center
        self.addSubview(nameLabel!)
        
        self.cornerRadius = 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.colorWithHex(hex: "0f0f0f").cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

protocol JMainBabiesScrollViewDelegate{
    func babiesScrollViewClicked(index: Int)
}

class JMainBabiesScrollView: UIScrollView {

    var clickedDelegate: JMainBabiesScrollViewDelegate?
    
    var selectedIndex: Int? = -1{
        willSet{
            let preView = self.viewWithTag(100 + selectedIndex!)
            preView?.backgroundColor = UIColor.colorWithHex(hex: "999999")
        }
        
        didSet{
            let newView = self.viewWithTag(100 + selectedIndex!)
            newView?.backgroundColor = UIColor.colorWithHex(hex: "666666")
        }
    }
    
    var babies: Array<BBaby>?{
        didSet{
            for v in self.subviews{
                v.removeFromSuperview()
            }
            var right: CGFloat = 0.0
            if babies == nil {return}
            for (index, baby) in (babies?.enumerated())!{    
                
                let textWidth = baby.babyname?.size(font: UIFont.systemFont(ofSize: 13), constrainedSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.height)).width
                
                let avatarView = JMainBabyAvatarView(frame: CGRect(x: right, y: 0, width: textWidth! + 30, height: self.height))
                right = avatarView.right + 8
                avatarView.baby = baby
                self.addSubview(avatarView)
                avatarView.tag = 100 + index
                avatarView.addTarget(self, action: #selector(clicked(control:)), for: .touchUpInside)
                self.addSubview(avatarView)
            }
            if selectedIndex! >= (babies?.count)! || selectedIndex! < 0{
                selectedIndex = 0
            }
            
            self.contentSize = CGSize(width: max(right+1, self.width+1), height: self.height)
        }
    }

    func clicked(control: JMainBabyAvatarView) {
        let tag = control.tag - 100
        if tag == selectedIndex{return}
        clickedDelegate?.babiesScrollViewClicked(index: tag)
        selectedIndex = tag
    }
}
