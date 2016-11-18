//
//  BLoginViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/15.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BLoginViewController: JBaseViewController, UITextFieldDelegate {

    var textBackView: UIView?
    var accountTextField: UITextField?
    var passwordTextField: UITextField?
    
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppearance), name: .UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        self.initializeSubviews()

    }
    
    func initializeSubviews(){
        scrollView = UIScrollView(frame: self.view.bounds);
        scrollView?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight]
        self.view.addSubview(self.scrollView!)
        
        let titleLabel = UILabel(frame: CGRect(x: 60, y: 40, width: Util.screenWidth() - 120, height: 60))
        titleLabel.font = UIFont.systemFont(ofSize: 36)
        titleLabel.textColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        titleLabel.shadowColor = UIColor.colorWithHexAndAlpha(hex: "5ba9c2", alpha: 1)
        titleLabel.shadowOffset = CGSize(width: 1.5, height: 1.5)
        titleLabel.text = "宝宝护理"
        titleLabel.textAlignment = .center
        scrollView?.addSubview(titleLabel)
        
        textBackView = UIView(frame: CGRect(x: 20, y: titleLabel.bottom+40, width: Util.screenWidth() - 40, height: 80))
        textBackView?.backgroundColor = UIColor.white
        textBackView?.layer.masksToBounds = true
        textBackView?.layer.cornerRadius = 4
        textBackView?.layer.borderColor = UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 0.4).cgColor
        textBackView?.layer.borderWidth = 0.5
        scrollView?.addSubview(textBackView!)
        
        
        let phoneIconImg = UIImageView(frame: CGRect(x: 6, y: 12.5, width: 15, height: 15))
        phoneIconImg.image = UIImage(named: "login_phone")
        textBackView?.addSubview(phoneIconImg)
        
        
        accountTextField = UITextField(frame: CGRect(x: phoneIconImg.right + 6, y: 5, width: (textBackView?.width)! - phoneIconImg.right - 6 - 10, height: 30))
        accountTextField?.font = UIFont.systemFont(ofSize: 14)
        accountTextField?.tintColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        accountTextField?.keyboardType = .numberPad
        accountTextField?.delegate = self
        accountTextField?.placeholder = "手机号码"
        textBackView?.addSubview(accountTextField!)
        
        let line = JOnePixLineView(frame: CGRect(x: 0, y: (accountTextField?.bottom)!+5, width: (textBackView?.width)!, height: 0.5))
        line.lineColor = UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 0.4)
        textBackView?.addSubview(line)
        
        let pwIconImg = UIImageView(frame: CGRect(x: 6, y: line.bottom + 12.5, width: 15, height: 15))
        pwIconImg.image = UIImage(named: "login_password")
        textBackView?.addSubview(pwIconImg)
        
        passwordTextField = UITextField(frame: CGRect(x: pwIconImg.right + 6, y:line.bottom + 5, width: (textBackView?.width)! - pwIconImg.right - 6 - 10, height: 30))
        passwordTextField?.font = UIFont.systemFont(ofSize: 14)
        passwordTextField?.tintColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        passwordTextField?.keyboardType = .numbersAndPunctuation
        passwordTextField?.delegate = self
        passwordTextField?.placeholder = "密码"
        textBackView?.addSubview(passwordTextField!)
        
        let loginBtn = UIButton(frame: CGRect(x: (textBackView?.left)!, y: (textBackView?.bottom)! + 30, width: (textBackView?.width)!, height: 40))
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4
        loginBtn.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        scrollView?.addSubview(loginBtn)
        
        let findPasswordBtn = UIButton(frame: CGRect(x: ((scrollView?.width)!-60)/2, y: loginBtn.bottom + 10, width: 60, height: 30))
        findPasswordBtn.setTitle("忘记密码?", for: .normal)
        findPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        findPasswordBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "", alpha: 0.4), for: .normal)
        findPasswordBtn.addTarget(self, action: #selector(findPassword), for: .touchUpInside)
        scrollView?.addSubview(findPasswordBtn)
    }
    
    
    func login(){
        HttpManager.requestAsynchronous(url: "login", parameters: ["mobile":(accountTextField?.text)!,"password":(passwordTextField?.text)!], completion: {
            object in
            let dic = object as! Dictionary<String, Any>
            let user = BUser.entityElement(data: dic["data"] as! Dictionary<String, Any>)
            
            JCacheManager.sharedInstance().setCache(user, forKey: "buser");
            
            let cache = JCacheManager.sharedInstance().cache(forKey: "buser") as! BUser;
            print(cache)
        })
    }
    
    func findPassword(){
        
    }
    
    //MARK: -- keyboard
    
    func keyboardWillAppearance(){
        
    }
    
    func keyboardWillHide(){
        
    }

}
