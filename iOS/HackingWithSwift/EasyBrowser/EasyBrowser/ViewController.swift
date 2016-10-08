//
//  ViewController.swift
//  EasyBrowser
//
//  Created by David Petrofsky on 10/8/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:
            "Open", style: .plain, target: self, action:
            #selector(openTapped))
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message:
            nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com",
                                   style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com",
                                   style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

