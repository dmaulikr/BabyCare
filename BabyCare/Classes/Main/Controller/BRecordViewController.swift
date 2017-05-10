//
//  BRecordViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/21.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

let BabyChanged = NSNotification.Name("app.bb.babychanged")
var currentBaby: BBaby?

class BRecordViewController: JBaseViewController, BSegmentControlDelegate, BMainBabiesScrollViewDelegate {
    
    
    
    var babiesView: BMainBabiesScrollView?
    
    var preViewController: JBaseViewController?
    
    lazy var _breastMilkViewController: BBreastMilkViewController = BBreastMilkViewController()
    lazy var _bottledMilkViewController: BBottledMilkViewController = BBottledMilkViewController()
    
    var segmentControl: BSegmentControl?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.preViewController?.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        babiesView = BMainBabiesScrollView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 40))
                
        babiesView?.clickedDelegate = self
        self.view.addSubview(babiesView!)
        self.updateCurrentBaby(index: 0)
        
        segmentControl = BSegmentControl(with: ["母乳","奶瓶"])
        segmentControl?.origin = CGPoint(x: 0, y: (babiesView?.bottom)!)
        segmentControl?.delegate = self
        segmentControl?.selectedIndex = 0
        self.view.addSubview(segmentControl!)

        self.addChildViewController(_breastMilkViewController)
        self.addChildViewController(_bottledMilkViewController)
        
        self.view.addSubview(_breastMilkViewController.view)
        preViewController = _breastMilkViewController
        _breastMilkViewController.view.frame = CGRect(x: 0, y: (segmentControl?.bottom)!, width: self.view.width, height: self.view.height - (segmentControl?.height)! - (babiesView?.height)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(needUpdateBabies(notification:)
            ), name: UserInfoUpdateNotification, object: nil)
        
    }
    
    func updateCurrentBaby(index: Int) {
        let user = BUserSession.instance.user
        if user == nil {
            return
        }
        let babies: Array<BBaby> = BUserSession.instance.user?.babies as! Array<BBaby>
        babiesView?.babies = babies
        currentBaby = babies[index]
    }
    
    func setSelectIndex(index: Int) {
        let controller = self.childViewControllers[index]
        if preViewController == controller {
            return
        }
        controller.view.frame = CGRect(x: 0, y: (segmentControl?.bottom)!, width: self.view.width, height: self.view.height - (segmentControl?.height)! - (babiesView?.height)!)
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
    
    func needUpdateBabies(notification: Notification) {
        babiesView?.babies = BUserSession.instance.user?.babies as! Array<BBaby>?
    }
    
    //MARK: delegate
    
    func babiesScrollViewClicked(index: Int) {
        self.updateCurrentBaby(index: index)
        NotificationCenter.default.post(name: BabyChanged, object: nil)
    }
    
    func segmentSelected(index: Int) {
        self.setSelectIndex(index: index)
    }
}
