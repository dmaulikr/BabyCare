//
//  JBaseViewController.swift
//  Poems
//
//  Created by Neo on 16/9/27.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorWithHex(hex: "eaeaea")
        if self.responds(to: #selector(getter: edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge();
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.backBarButtonItem = nil
        if let count = self.navigationController?.viewControllers.count {
            if count>1 {
                self.navigationItem.leftBarButtonItem = Util.barButtonItem(image: UIImage(named: "poem_back")!, target: self, action: #selector(backAction), imageEdgeInsets: UIEdgeInsets.zero)
            }
        }
    }

    func backAction() {
        self.navigationController!.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    override var supportedInterfaceOrientations:UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation:UIInterfaceOrientation{
        return .portrait
    }
}
