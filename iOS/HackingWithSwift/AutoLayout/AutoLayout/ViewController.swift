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
        
        var labels: [String:UILabel] = [:]
        labels["label1"] = addLabel(backgroundColor: .red, text: "THESE")
        labels["label2"] = addLabel(backgroundColor: .cyan, text: "ARE")
        labels["label3"] = addLabel(backgroundColor: .yellow, text: "SOME")
        labels["label4"] = addLabel(backgroundColor: .green, text: "AWESOME")
        labels["label5"] = addLabel(backgroundColor: .orange, text: "LABELS")
        
        //horizontal layout
        for label in labels.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil,
                                                    views: labels))
        }
        //vertical layout
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
                                                            "V:|[label1]-[label2]-[label3]-[label4]-[label5]",
                                                           options: [], metrics: nil, views: labels))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addLabel(backgroundColor: UIColor, text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = backgroundColor
        label.text = text
        
        view.addSubview(label)
        
        return label
    }
}

