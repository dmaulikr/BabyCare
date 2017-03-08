//
//  BRecordViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/21.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BRecordViewController: JBaseViewController, JSegmentControlDelegate {
    
    var preViewController: JBaseViewController?
    
    lazy var _breastMilkViewController: BBreastMilkViewController = BBreastMilkViewController()
    lazy var _bottledBreastMilkViewController: BBottledBreastMilkViewController = BBottledBreastMilkViewController()
    lazy var _milkViewController: BMilkViewController = BMilkViewController()
    
    var segmentControl: JSegmentControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl = JSegmentControl(with: ["母乳喂养","母乳奶瓶","配方奶"])
        segmentControl?.delegate = self
        self.view.addSubview(segmentControl!)

        self.addChildViewController(_breastMilkViewController)
        self.addChildViewController(_bottledBreastMilkViewController)
        self.addChildViewController(_milkViewController)
        self.view.addSubview(_breastMilkViewController.view)
        preViewController = _breastMilkViewController
        _breastMilkViewController.view.frame = CGRect(x: 0, y: (segmentControl?.bottom)!, width: self.view.width, height: self.view.height - (segmentControl?.height)!)

    }
    
    func setSelectIndex(index: Int){
        let controller = self.childViewControllers[index]
        if preViewController == controller {
            return
        }
        controller.view.frame = CGRect(x: 0, y: (segmentControl?.bottom)!, width: self.view.width, height: self.view.height - (segmentControl?.height)!)
        self.transition(from: preViewController!, to: controller, duration: 0, options: .curveEaseOut, animations: {
            [weak self] in
            
            self?.preViewController?.view.alpha = 0
            controller.view.alpha = 1
            }, completion: {
                [weak self] complete in
                self?.preViewController = controller as? JBaseViewController
                //            self?.view.bringSubview(toFront: (self?.tabBar)!)
        })
    }
    
    func segmentSelected(index: Int) {
        self.setSelectIndex(index: index)
    }
}
