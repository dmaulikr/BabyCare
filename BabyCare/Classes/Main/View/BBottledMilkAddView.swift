//
//  BBottleMilkAddView.swift
//  BabyCare
//
//  Created by Neo on 2017/3/21.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

protocol BBottledMilkAddViewDelegate {
    func addViewDone(amount: Int, type: Int)
}

class BBottledMilkAddView: JCoverShadowView, UIPickerViewDelegate, UIPickerViewDataSource {

    var panelView: UIView?
    
    var animating: Bool = false
    
    var pickView: UIPickerView?
    
    var delegate: BBottledMilkAddViewDelegate?
    
    lazy var leftSource: Array<Int> = {
        return [50,100,150,200,250,300,350,400]
    }()
    
    lazy var rightSource: Array<Int> = {
        return [10,15,20,25,30,35,40,45]
    }()
    
    lazy var types: Array<Int> = {
        return [0,1]
    }()
    
    var leftIndex: Int = 0
    var rightIndex: Int = 0
    
    var typeIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        panelView = UIView(frame: CGRect(x: 0, y: frame.height, width: self.width, height: 260))
        panelView?.backgroundColor = UIColor.white
        
        
        
        let closeButton = UIButton(frame: CGRect(x: frame.width - 70 , y: 10, width: 60, height: 30))
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 1), for: .normal)
        closeButton.contentHorizontalAlignment = .right
        panelView?.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        pickView = UIPickerView(frame: CGRect(x: 0, y: closeButton.bottom, width: frame.width, height: 200))
        pickView?.delegate = self
        pickView?.dataSource = self
        panelView?.addSubview(pickView!)
        
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
        
    }    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func close() {
        leftIndex = 0
        rightIndex = 0
        typeIndex = 0
        self.hide()
        pickView?.selectRow(0, inComponent: 0, animated: false)
        pickView?.selectRow(0, inComponent: 2, animated: false)
        pickView?.selectRow(0, inComponent: 3, animated: false)
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
    
    // MARK: ---- delegate data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return leftSource.count
        case 2:
            return rightSource.count
        case 3:
            return types.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(leftSource[row]) + "ml"
        case 2:
            return String(rightSource[row]) + "ml"
        case 3:
            return types[row] == 0 ?"母乳" : "配方奶"
        default:
            return "+"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            leftIndex = row
        case 2:
            rightIndex = row
        case 3:
            typeIndex = row
        default: break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 1 {
            return 50.0
        }else if component == 3 {
            return 100
        }
        return 80
    }
    
    // MARK: --- 添加
    
    func done() {
        delegate?.addViewDone(amount: leftSource[leftIndex] + rightSource[rightIndex], type: typeIndex)
        self.close()
    }
}
