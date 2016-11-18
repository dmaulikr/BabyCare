//
//  JNavigationController.swift
//  Poems
//
//  Created by Neo on 16/10/31.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor.colorWithHexAndAlpha(hex: "313131", alpha: 1)
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
        
        self.navigationBar.shadowImage = UIImage()
    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self.viewControllers.count > 0 {
            return true
        }
        return false
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override var shouldAutorotate: Bool{
        return (self.topViewController?.shouldAutorotate)!
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask{
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation:UIInterfaceOrientation{
        return (self.topViewController?.preferredInterfaceOrientationForPresentation)!
    }
}
