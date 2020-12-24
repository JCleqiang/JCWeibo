//
//  JCCommonWebViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/3.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class JCCommonWebViewController: UIViewController {
    
    override func loadView() {
        view = self.webView
    }
    
    var path: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(leftback))
        
        guard let pathStr = path else {
            SVProgressHUD.showError(withStatus: "path 为 nil")
            return
        }
        
        guard let url = URL(string: pathStr) else {
            SVProgressHUD.showError(withStatus: "url 为 nil")
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    @objc func leftback() {
        SVProgressHUD.dismiss()
        navigationController!.popViewController(animated: true)
    }

    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = UIColor.red
        webView.navigationDelegate = self
        
        return webView
    }()
}

extension JCCommonWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show(withStatus: "正在加载")
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.showError(withStatus: "加载失败")
    }
}
