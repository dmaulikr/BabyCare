//
//  BMainViewController.swift
//  babycare
//
//  Created by Neo on 2016/11/15.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BMainViewController: JBaseViewController, BMainTabBarDelegate {
    
    var tabBar: BMainTabBar?
    
    var controllers: Array<JBaseViewController>?
    var preController: JBaseViewController?

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
        
        tabBar = BMainTabBar()
        tabBar?.delegate = self
        tabBar?.origin = CGPoint(x: 0, y: self.view.height - (tabBar?.height)!)
        tabBar?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        tabBar?.selectedIndex = 0
        self.view.addSubview(tabBar!)
    }
    
    func setSelectIndex(index: Int){
        let controller = controllers?[index]
        if controller == preController {
            return
        }
        
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
        
    }
}
