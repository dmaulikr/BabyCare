//
//  JWebViewController.swift
//  BabyCare
//
//  Created by Neo on 2016/11/20.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

class JWebViewController: JBaseViewController, UIWebViewDelegate {

    var webUrl: String?
    
    var webView: UIWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: self.view.bounds)
        webView?.backgroundColor = UIColor.clear
        webView?.scrollView.backgroundColor = UIColor.clear
        webView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        webView?.delegate = self
        
        self.view.addSubview(webView!)
        
        if (webUrl?.characters.count)! > 0 {
            webView?.loadRequest(URLRequest(url: URL(string: webUrl!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60))
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        Hud.showHudView(inView: self.view, lock: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Hud.hide()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        Hud.show(content: "加载失败", withTime: 3)
    }
    
    deinit {
        Hud.hide()
        webView?.stopLoading()
        webView?.delegate = nil
        webView = nil
    }
}
