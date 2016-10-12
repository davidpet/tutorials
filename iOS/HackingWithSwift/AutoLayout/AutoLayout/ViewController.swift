//
//  ViewController.swift
//  AutoLayout
//
//  Created by David Petrofsky on 10/11/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel(backgroundColor: .red, text: "THESE")
        addLabel(backgroundColor: .cyan, text: "ARE")
        addLabel(backgroundColor: .yellow, text: "SOME")
        addLabel(backgroundColor: .green, text: "AWESOME")
        addLabel(backgroundColor: .orange, text: "LABELS")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addLabel(backgroundColor: UIColor, text: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = backgroundColor
        label.text = text
        
        view.addSubview(label)
    }
}

