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
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppearance), name: .UIKeyboardWillShow, object: nil)        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        self.initializeSubviews()

    }
    
    func initializeSubviews(){
        
        scrollView = UIScrollView(frame: self.view.bounds);
        scrollView?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight]
        self.view.addSubview(self.scrollView!)
        
        let cancleGesture = UITapGestureRecognizer(target: self, action: #selector(cancleKeyboard))
        scrollView?.addGestureRecognizer(cancleGesture)
        
        
        let closeBtn = UIButton(frame: CGRect(x: self.view.width - 60, y: 10, width: 40, height: 40))
        closeBtn.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        closeBtn.setImage(UIImage(named: "common_close"), for: .normal)
        self.view.addSubview(closeBtn)
        
        let titleLabel = UILabel(frame: CGRect(x: 60, y: 50, width: Util.screenWidth() - 120, height: 60))
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        titleLabel.font = UIFont(name: "Zapfino", size: 28)
        titleLabel.textColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        titleLabel.shadowColor = UIColor.colorWithHexAndAlpha(hex: "5ba9c2", alpha: 1)
        titleLabel.shadowOffset = CGSize(width: 1.5, height: 1.5)
        titleLabel.text = "BabyCare"
        titleLabel.textAlignment = .center
        scrollView?.addSubview(titleLabel)
        
        textBackView = UIView(frame: CGRect(x: 40, y: titleLabel.bottom+40, width: Util.screenWidth() - 80, height: 80))
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
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.tintColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        passwordTextField?.keyboardType = .numbersAndPunctuation
        passwordTextField?.delegate = self
        passwordTextField?.placeholder = "密码"
        textBackView?.addSubview(passwordTextField!)
        
        let findPasswordBtn = UIButton(frame: CGRect(x: ((scrollView?.width)!)/2+30, y: (textBackView?.bottom)! + 10, width: (textBackView?.width)!/2 - 30, height: 30))
        findPasswordBtn.setTitle("忘记密码?", for: .normal)
        findPasswordBtn.contentHorizontalAlignment = .right
        findPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        findPasswordBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "", alpha: 0.4), for: .normal)
        findPasswordBtn.addTarget(self, action: #selector(findPassword), for: .touchUpInside)
        scrollView?.addSubview(findPasswordBtn)
        
        let registerBtn = UIButton(frame: CGRect(x: (textBackView?.left)!, y: findPasswordBtn.top, width: (textBackView?.width)!/2 - 30, height: 30))
        registerBtn.setTitle("新用户注册", for: .normal)
        registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        registerBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "fd6666", alpha: 1), for: .normal)
        registerBtn.contentHorizontalAlignment = .left
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        scrollView?.addSubview(registerBtn)
        
        let loginBtn = UIButton(frame: CGRect(x: (textBackView?.left)!, y: registerBtn.bottom + 10, width: (textBackView?.width)!, height: 40))
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4
        loginBtn.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        scrollView?.addSubview(loginBtn)
    }
    
    func login(){
        let mobile = accountTextField?.text
        let password = passwordTextField?.text
        
        if mobile?.characters.count != 11 {
            Hud.show(content: "手机号错误", withTime: 2)
            return
        }
        
        if (password?.isEmpty)! {
            Hud.show(content: "请输入密码", withTime: 2)
            return
        }
        
        HttpManager.requestAsynchronous(url: "login", parameters: ["mobile":(accountTextField?.text)!,"password":(passwordTextField?.text)!], completion: {
            object in
            let dic = object as! Dictionary<String, Any>
            if (dic["code"] as! Int) == 0{
                BUserSession.instance.updateUser(with: dic["data"] as! Dictionary<String, Any>)
                self.dismiss(animated: true, completion: { 
                    
                })
            }else{
                Hud.show(content: dic["msg"] as! String, withTime: 3)
            }          
        })
    }
    
    func findPassword(){
        
    }
    
    func register(){
        let controller = BRegisterViewController()
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: {})
    }
    
    func visitor(){
        
    }
    
    
    func closeController(){
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    //MARK: -- keyboard
    
//    func keyboardWillAppearance(){
//        
//    }
//    
//    func keyboardWillHide(){
//        
//    }
    
    func cancleKeyboard(){
        accountTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }

}
