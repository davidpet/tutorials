//
//  ViewController.swift
//  MultiBrowser
//
//  Created by David Petrofsky on 11/17/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!

    weak var activeWebView: UIWebView?      //weak because could go away if user deletes it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultTitle()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                  action: #selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash,
                                     target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [delete, add]
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setDefaultTitle() {
        title = "Multibrowser"
    }
    
    func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        
        stackView.addArrangedSubview(webView)
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.loadRequest(URLRequest(url: url))
        
        webView.layer.borderColor = UIColor.blue.cgColor
        selectWebView(webView)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
    }
    
    func selectWebView(_ webView: UIWebView) {
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        activeWebView = webView
        webView.layer.borderWidth = 3
    }
    
    func webViewTapped(_ recognizer: UITapGestureRecognizer) {
        if let selectedWebView = recognizer.view as? UIWebView {
            selectWebView(selectedWebView)
        }
    }
    
    func deleteWebView() {
    }
}
