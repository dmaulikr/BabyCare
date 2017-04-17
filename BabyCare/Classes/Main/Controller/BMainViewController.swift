//
//  BMainViewController.swift
//  babycare
//
//  Created by Neo on 2016/11/15.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit
var mainViewController: BMainViewController?

class BMainViewController: JBaseViewController, BMainTabBarDelegate {
    
    var tabBar: BMainTabBar?
    
    // controllers

    var preController: JBaseViewController?
    lazy var _recordController: BRecordViewController = BRecordViewController()
    lazy var _scheduleController: BScheduleViewController = BScheduleViewController()
    lazy var _mineController: BMineViewController = BMineViewController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !BUserSession.instance.sessionValid {
            self.presentLoginController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewController = self

        self.addChildViewController(_recordController)
        self.addChildViewController(_scheduleController)
        self.addChildViewController(_mineController)
        
        self.title = "喂奶"
        
        tabBar = BMainTabBar()
        tabBar?.delegate = self
        tabBar?.origin = CGPoint(x: 0, y: self.view.height - (tabBar?.height)!)
        tabBar?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        tabBar?.selectedIndex = 0
        self.view.addSubview(tabBar!)
        
        _recordController.view.height = self.view.height - (tabBar?.height)!
        self.view.addSubview(_recordController.view)
        preController = _recordController
        
    }
    
    func setSelectIndex(index: Int){
        let controller = self.childViewControllers[index]
        if preController == controller {
            return
        }
        
        switch index {
        case 0:
            self.title = "喂奶"
        case 1:
            self.title = "记录"
        case 2:
            self.title = "我的"
        default:
            break
        }
        controller.view.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - (tabBar?.height)!)

        self.transition(from: preController!, to: controller, duration: 0, options: .curveEaseOut, animations: {
            [weak self] in
            self?.view.bringSubview(toFront: (self?.tabBar)!)

            self?.preController?.view.alpha = 0
            controller.view.alpha = 1
        }, completion: {
           [weak self] complete in
            self?.preController = controller as? JBaseViewController
//            self?.view.bringSubview(toFront: (self?.tabBar)!)
        })
    }
    
    func presentLoginController(){
        
        let loginVC = BLoginViewController()
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: false, completion: { 
        })
    }

    func clicked(){

    }
    
    func tabBarClicked(index: Int) {
        if index>0 {
            self.navigationItem.rightBarButtonItem = nil
        }
        self.setSelectIndex(index: index)
    }
}
