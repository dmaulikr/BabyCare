//
//  JSegmentControl.swift
//  BabyCare
//
//  Created by Neo on 2016/11/21.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

protocol JSegmentControlDelegate {
    func segmentSelected(index: Int)
}

class JSegmentControl: UIView {

    var items = [UIButton]()
    var flagView: UIView?
    
    var delegate: JSegmentControlDelegate?
    var selectedIndex: Int = 0{
        willSet{
            let preBtn = items[selectedIndex]
            preBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 1), for: .normal)
        }
        
        didSet{
            let currentBtn = items[selectedIndex]
            currentBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 1), for: .normal)
            UIView.animate(withDuration: 0.25, animations: {
                [weak self] in
                self?.flagView?.left = (currentBtn.width+0.5) * CGFloat((self?.selectedIndex)!)
            })
        }
    }
    
    convenience init(with titles: [String]){
        self.init(frame:CGRect(x: 0, y: 0, width: Util.screenWidth(), height: 28))
        assert(titles.count > 0, "segment count error")
        let width = (self.width - CGFloat(titles.count) * 0.5)/CGFloat(titles.count)
        
        flagView = UIView(frame: CGRect(x: 0, y: self.height - 2, width: width, height: 2))
        flagView?.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "333333", alpha: 1)
        self.addSubview(flagView!)
        
        for i in 0..<titles.count {
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * (width + 0.5), y: 0, width: width, height: self.height))
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitle(titles[i], for: .normal)
            btn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "", alpha: 1), for: .normal)
            btn.addTarget(self, action: #selector(segmentClicked(item:)), for: .touchUpInside)
            self.addSubview(btn)
            items.append(btn)
            
            if i == titles.count - 1 {
                continue
            }
            
            let vLine = UIView(frame: CGRect(x: btn.right, y: 4, width: 0.5, height: 20))
            vLine.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 1)
            self.addSubview(vLine)
        }
    }
    
    func segmentClicked(item: UIButton){
        let index = items.index(of: item)
        if index == self.selectedIndex {
            return
        }
        self.selectedIndex = index!
        delegate?.segmentSelected(index: index!)
    }

}
