//
//  BBreastMilkAddView.swift
//  BabyCare
//
//  Created by Neo on 2017/3/20.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

protocol BBreastMilkAddViewDelegate {
    func addViewDone(left: Int, right: Int)
}

class BBreastMilkAddView: JCoverShadowView {
    
    var delegate: BBreastMilkAddViewDelegate?

    var leftTime = 0
    var rightTime = 0
    
    var leftButton: UIButton?
    var rightButton: UIButton?
    
    var leftTimeLabel: UILabel?
    var rightTimeLabel: UILabel?
    
    var leftTimer: Timer?
    var rightTimer: Timer?
    
    var panelView: UIView?
    
    var animating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        panelView = UIView(frame: CGRect(x: 0, y: frame.height, width: self.width, height: 260))
        panelView?.backgroundColor = UIColor.white
        let restartButton = UIButton(frame: CGRect(x:10 , y: 10, width: 60, height: 30))
        restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        restartButton.setTitle("重新开始", for: .normal)
        restartButton.contentHorizontalAlignment = .left
        restartButton.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)
        
        panelView?.addSubview(restartButton)
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        
        let closeButton = UIButton(frame: CGRect(x: frame.width - 70 , y: 10, width: 60, height: 30))
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)
        closeButton.contentHorizontalAlignment = .right
        panelView?.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        let leftDesLabel = UILabel(frame: CGRect(x: 60, y: closeButton.bottom + 20, width: 60, height: 20))
        leftDesLabel.textAlignment = .center
        leftDesLabel.font = UIFont.systemFont(ofSize: 12)
        leftDesLabel.text = "左侧"
        panelView?.addSubview(leftDesLabel)
        
        leftButton = UIButton(frame: CGRect(x: leftDesLabel.left, y: leftDesLabel.bottom + 10, width: leftDesLabel.width, height: 60))
        leftButton?.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)

        leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        leftButton?.setTitle("开始", for: .normal)
        panelView?.addSubview(leftButton!)
        leftButton?.layer.cornerRadius = 30
        leftButton?.layer.borderColor = UIColor.colorWithHexAndAlpha(hex: "1a1a1a", alpha: 1).cgColor
        leftButton?.layer.borderWidth = 0.5
        leftButton?.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
        
        leftTimeLabel = UILabel(frame: CGRect(x: 30, y: (leftButton?.bottom)! + 4, width: 120, height: 30))
        leftTimeLabel?.textAlignment = .center
        leftTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        panelView?.addSubview(leftTimeLabel!)
        leftTimeLabel?.text = "0秒"
        
        let rightDesLabel = UILabel(frame: CGRect(x: frame.width - 60 - 60, y: leftDesLabel.top, width: leftDesLabel.width, height: 20))
        rightDesLabel.textAlignment = .center
        rightDesLabel.font = UIFont.systemFont(ofSize: 12)
        rightDesLabel.text = "右侧"
        panelView?.addSubview(rightDesLabel)
        
        rightButton = UIButton(frame: CGRect(x: rightDesLabel.left, y: (leftButton?.top)!, width: leftDesLabel.width, height: 60))
        rightButton?.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)
        rightButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        rightButton?.setTitle("开始", for: .normal)
        panelView?.addSubview(rightButton!)
        
        rightButton?.layer.cornerRadius = 30
        rightButton?.layer.borderColor = UIColor.colorWithHexAndAlpha(hex: "1a1a1a", alpha: 1).cgColor
        rightButton?.layer.borderWidth = 0.5
        rightButton?.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        
        rightTimeLabel = UILabel(frame: CGRect(x: (rightButton?.left)! - 30, y: (leftTimeLabel?.top)! , width: 120, height: 30))
        rightTimeLabel?.textAlignment = .center
        rightTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        panelView?.addSubview(rightTimeLabel!)
        rightTimeLabel?.text = "0秒"
        
        let doneButton: UIButton = UIButton(frame: CGRect(x: 60, y: (panelView?.height)! - 40, width: frame.width - 120, height: 30))
        doneButton.setTitle("添加", for: .normal)
        doneButton.layer.borderColor = UIColor.colorWithHexAndAlpha(hex: "333333", alpha: 0.8).cgColor
        doneButton.cornerRadius = 5
        
        panelView?.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        doneButton.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderColor = UIColor.colorWithHexAndAlpha(hex: "1a1a1a", alpha: 1).cgColor
        doneButton.layer.borderWidth = 0.5
        self.addSubview(panelView!)
        
//        self.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func restart() {
        leftTime = 0
        rightTime = 0
        
        if (leftTimer != nil) && (leftTimer?.isValid)! {
            leftTimer?.invalidate()
        }
        
        if rightTimer != nil && (rightTimer?.isValid)! {
            rightTimer?.invalidate()
        }
        leftTimeLabel?.text = "0秒"
        rightTimeLabel?.text = "0秒"
        leftButton?.setTitle("开始", for: .normal)
        rightButton?.setTitle("开始", for: .normal)
    }
    
    func show() {
        
        if animating {return}
        animating = true
        
        UIView.animate(withDuration: 0.25, animations: {
            [weak self] in
            self?.alpha = 1
            self?.panelView?.top = (self?.height)! - (self?.panelView?.height)!
            
        }) { [weak self] finished in
            self?.animating = false
        }
    }
    
    func leftPause() {
        
        if leftTimer != nil && (leftTimer?.isValid)! {
            leftTimer?.invalidate()
            leftTimer = nil
        }
        leftButton?.setTitle("继续", for: .normal)
    }
    
    func leftResume() {
        if leftButton?.titleLabel?.text != "暂停" {
            if leftTimer == nil || !(leftTimer?.isValid)! {
                leftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(leftTimerRun), userInfo: nil, repeats: true)
            }
            leftButton?.setTitle("暂停", for: .normal)
        }
    }
    
    func rightPause() {
        if rightTimer != nil && (rightTimer?.isValid)! {
            rightTimer?.invalidate()
            rightTimer = nil
        }
        rightButton?.setTitle("继续", for: .normal)
    }
    
    func rightResume() {
        if rightButton?.titleLabel?.text != "暂停" {
            if rightTimer == nil || !(rightTimer?.isValid)! {
                rightTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(rightTimerRun), userInfo: nil, repeats: true)
            }
            rightButton?.setTitle("暂停", for: .normal)
        }
    }
    
    func hide() {
        if animating{
            return
        }
        animating = true
        UIView.animate(withDuration: 0.25, animations: {
            [weak self] in
            self?.alpha = 0
            self?.panelView?.top = (self?.height)!
            
        }) {[weak self] finished in
            self?.animating = false
        }
    }
    
    func close() {
        self.restart()
        self.hide()
        
    }
    
    func done() {
        self.hide()
        delegate?.addViewDone(left: leftTime, right: rightTime)
    }
    
    func leftButtonClicked(button: UIButton) {
        if button.titleLabel?.text != "暂停" {
            self.leftResume()
        } else {
            self.leftPause()
        }
        self.rightPause()
    }

    func leftTimerRun(timer: Timer) {
        leftTime = leftTime + 1
        leftTimeLabel?.text = self.translateSecondToMinute(second: leftTime)
    }
    
    
    func translateSecondToMinute(second: Int) -> String {
        if second < 60 {
            return String(second) + "秒"
        }
        let minute = Int(second/60)
        let mod = Int(second - minute * 60)
        return String(minute) + "分" + String(mod) + "秒"
    }
    
    func rightButtonClicked(button: UIButton) {
        if button.titleLabel?.text != "暂停" {
            self.rightResume()
        } else {
            self.rightPause()
        }
        self.leftPause()
    }
    
    func rightTimerRun(timer: Timer) {
        rightTime = rightTime + 1
        rightTimeLabel?.text = self.translateSecondToMinute(second: rightTime)
    }
    
}
