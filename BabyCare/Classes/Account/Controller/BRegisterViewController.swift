//
//  BRegisterViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/20.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class BRegisterViewController: JBaseViewController, UITextFieldDelegate {

    var textBackView: UIView?
    var accountTextField: UITextField?
    var verifyCodeTextField: UITextField?
    var passwordTextField: UITextField?
    var verifyCodeButton: UIButton?
    var timer: Timer?
    
    var countDownNumber: Int = 59
    
    var scrollView: UIScrollView?
    
    let webViewController = JWebViewController()
    
    deinit {
        timer = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        textBackView = UIView(frame: CGRect(x: 40, y: titleLabel.bottom+40, width: Util.screenWidth() - 80, height: 120))
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
        
        let line1 = JOnePixLineView(frame: CGRect(x: 0, y: (accountTextField?.bottom)!+5, width: (textBackView?.width)!, height: 0.5))
        line1.lineColor = UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 0.4)
        textBackView?.addSubview(line1)
        
        let codeIconImg = UIImageView(frame: CGRect(x: 6, y: line1.bottom + 12.5, width: 15, height: 15))
        codeIconImg.image = UIImage(named: "register_verifyCode")
        textBackView?.addSubview(codeIconImg)
        
        verifyCodeTextField = UITextField(frame: CGRect(x: codeIconImg.right + 6, y:line1.bottom + 5, width: (textBackView?.width)! - phoneIconImg.right - 6 - 10 - 70, height: 30))
        verifyCodeTextField?.font = UIFont.systemFont(ofSize: 14)
        verifyCodeTextField?.tintColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        verifyCodeTextField?.keyboardType = .numberPad
        verifyCodeTextField?.delegate = self
        verifyCodeTextField?.placeholder = "验证码"
        textBackView?.addSubview(verifyCodeTextField!)
        
        verifyCodeButton = UIButton(frame: CGRect(x: (verifyCodeTextField?.right)!+5, y: (verifyCodeTextField?.top)!, width: 65, height: 30))
        verifyCodeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        verifyCodeButton?.setTitleColor(UIColor.white, for: .normal)
        verifyCodeButton?.setTitle("获取验证码", for: .normal)
        verifyCodeButton?.layer.masksToBounds = true
        verifyCodeButton?.layer.cornerRadius = 3
        verifyCodeButton?.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        verifyCodeButton?.addTarget(self, action: #selector(sendVerifyCode), for: .touchUpInside)
        textBackView?.addSubview(verifyCodeButton!)
        
        
        
        let line2 = JOnePixLineView(frame: CGRect(x: 0, y: (verifyCodeTextField?.bottom)!+5, width: (textBackView?.width)!, height: 0.5))
        line2.lineColor = UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 0.4)
        textBackView?.addSubview(line2)
        
        let pwIconImg = UIImageView(frame: CGRect(x: 6, y: line2.bottom + 12.5, width: 15, height: 15))
        pwIconImg.image = UIImage(named: "login_password")
        textBackView?.addSubview(pwIconImg)
        
        passwordTextField = UITextField(frame: CGRect(x: pwIconImg.right + 6, y:line2.bottom + 5, width: (textBackView?.width)! - pwIconImg.right - 6 - 10, height: 30))
        passwordTextField?.font = UIFont.systemFont(ofSize: 14)
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.tintColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        passwordTextField?.keyboardType = .numbersAndPunctuation
        passwordTextField?.delegate = self
        passwordTextField?.placeholder = "密码"
        textBackView?.addSubview(passwordTextField!)
        
        let description = "注册即代表接受 "
        let font =  UIFont.systemFont(ofSize: 12)
        let desSize = description.size(font: font, constrainedSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30))
        
        let protocolLabel = UILabel(frame: CGRect(x: (textBackView?.left)!, y: (textBackView?.bottom)!+10, width: desSize.width, height: 30))
        protocolLabel.font = font
        protocolLabel.textColor = UIColor.colorWithHexAndAlpha(hex: "", alpha: 1)
        protocolLabel.text = description
        scrollView?.addSubview(protocolLabel)
        
        let s = "用户协议"
        let sSize = s.size(font: font, constrainedSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30))
        
        let btn = UIButton(frame: CGRect(x: protocolLabel.right, y: protocolLabel.top, width: sSize.width, height: 30))
        btn.titleLabel?.font = font
        btn.setTitle(s, for: .normal)
        btn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(lookupProtocal), for: .touchUpInside)
        scrollView?.addSubview(btn)

        let registerBtn = UIButton(frame: CGRect(x: (textBackView?.left)!, y: btn.bottom + 10, width: (textBackView?.width)!, height: 40))
        registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = 4
        registerBtn.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 0.9)
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        scrollView?.addSubview(registerBtn)
    }

    func sendVerifyCode(){
        
        let mobile = accountTextField?.text
        
        if mobile?.characters.count != 11 {
            Hud.show(content: "手机号错误", withTime: 2)
            return
        }
        
        if timer != nil && (timer?.isValid)! {
            timer = nil
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        verifyCodeButton?.setTitle(String(countDownNumber), for: .normal)
        
        verifyCodeButton?.isUserInteractionEnabled = false
        
        
        HttpManager.requestAsynchronous(url: "verifycode/sendregistercode", parameters: ["mobile":mobile!], completion:{
            response in 
            let dic = response as! Dictionary<String, Any>
            if (dic["code"] as! Int) == 0 {
                Hud.show(content: "验证码已发送", withTime: 2)
            }else{
                if self.timer != nil{
                    self.verifyCodeButton?.setTitle("获取验证码", for: .normal)
                    self.countDownNumber = 59
                    self.timer?.invalidate()
                    self.timer = nil
                    self.verifyCodeButton?.isUserInteractionEnabled = true
                }
                Hud.show(content: dic["msg"] as! String, withTime: 2)
            }
        })
    }
    
    func countDown(){
        print("\(countDownNumber)")
        countDownNumber = countDownNumber - 1
        if countDownNumber <= 0 {
            verifyCodeButton?.setTitle("获取验证码", for: .normal)
            countDownNumber = 59
            timer?.invalidate()
            timer = nil
            verifyCodeButton?.isUserInteractionEnabled = true
        }else{
            verifyCodeButton?.setTitle(String(countDownNumber), for: .normal)
        }
    }
    
    func register(){
        let mobile = accountTextField?.text
        let verifyCode = verifyCodeTextField?.text
        let password = passwordTextField?.text
    
        
        if mobile?.characters.count != 11 {
            Hud.show(content: "手机号错误", withTime: 2)
            return
        }
        if (verifyCode?.characters.count)! <= 0 {
            Hud.show(content: "请正确输入验证码", withTime: 2)
            return
        }
        if (password?.characters.count)! <= 0 {
            Hud.show(content: "请输入密码", withTime: 2)
            return
        }
        
        HttpManager.requestAsynchronous(url: "register", parameters: ["mobile":mobile!,"verifycode":verifyCode!,"password":password!], completion: {
            response in
            let dic = response as! Dictionary<String, Any>
            if (dic["code"] as! Int) == 0{
                
                BUserSession.instance.updateUser(with: dic["data"] as! Dictionary<String, Any>)
                self.dismiss(animated: true, completion: {})
                
                
            }else{
                Hud.show(content: dic["msg"] as! String, withTime: 2)
            }
            
        })
        
    }
    
    func lookupProtocal(){
        
        webViewController.webUrl = "http://www.baidu.com"
        webViewController.modalTransitionStyle = .crossDissolve
                
        self.present(JNavigationController(rootViewController: webViewController), animated: true, completion: {
            [weak self] in
            self?.webViewController.title = "用户协议"
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitle("关闭", for: .normal)
            btn.addTarget(self, action:  #selector(self?.closeProtocal), for: .touchUpInside)
            
           self?.webViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        })
        
    }
    
    func closeProtocal(){
        webViewController.dismiss(animated: true, completion: {})
    }
    
    func closeController(){
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: {
            self.presentingViewController?.dismiss(animated: true, completion: {})
        })
    }
    
    func cancleKeyboard(){
        accountTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }
}
