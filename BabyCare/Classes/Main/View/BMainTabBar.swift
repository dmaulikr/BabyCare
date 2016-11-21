//
//  BMainTabBar.swift
//  BabyCare
//
//  Created by Neo on 2016/11/21.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

protocol BMainTabBarDelegate {
    func tabBarClicked(index: Int)
}

class BMainTabBar: UIView {

    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: Util.screenWidth(), height: 49))
        self.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "313131", alpha: 1)
//        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        effectView.frame = self.bounds
//        self.addSubview(effectView)
        
        let icons = [["","","随记"],
                     ["","","备忘"],
                     ["","","我的"]]
        let width = self.width/3
        
        for i in 0 ..< 3{
            let item = BMainTabBarItem(frame: CGRect(x: CGFloat(i) * width, y: 0, width: width, height: self.height), icons: icons[i])
            item.addTarget(self, action: #selector(itemClicked(control:)), for: .touchUpInside)
            tabContainer.append(item)
            self.addSubview(item)
        }
    }
    
    var delegate: BMainTabBarDelegate?
    
    var selectedIndex: Int = 0{
        willSet{
            let item = tabContainer[selectedIndex]
            item.isSelected = false
        }
        didSet{
            let item = tabContainer[selectedIndex]
            item.isSelected = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var icons: [Array<String>]?
    
    var tabContainer = [BMainTabBarItem]() 
    
    // func
    
    func itemClicked(control: BMainTabBarItem){
        let idx = tabContainer.index(of: control)
        if idx != selectedIndex{
            selectedIndex = idx!
            delegate?.tabBarClicked(index: selectedIndex)
        }
    }
}


class BMainTabBarItem: UIControl{
    
    var icons: Array<String>?
    
    init(frame: CGRect, icons: Array<String>) {
        super.init(frame: frame)
        self.icons = icons
        iconImageView = UIImageView(frame: CGRect(x: (self.width - 38)/2, y: 5, width: 38, height: 29))
        self.addSubview(iconImageView!)
        iconImageView?.image = UIImage(named: icons[0])
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: (iconImageView?.bottom)!, width: self.width, height: 12))
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleLabel?.textAlignment = .center
        
        titleLabel?.textColor = UIColor.colorWithHexAndAlpha(hex: "ffffff", alpha: 1)
        titleLabel?.text = icons[2]
        self.addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                iconImageView?.image = UIImage(named: (self.icons?[1])!)
                titleLabel?.textColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 1)
            }else{
                iconImageView?.image = UIImage(named: (self.icons?[0])!)
                titleLabel?.textColor = UIColor.colorWithHexAndAlpha(hex: "ffffff", alpha: 1)
            }
        }
    }
}
