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
        
        var labels: [UILabel] = []
        labels.append(addLabel(backgroundColor: .red, text: "THESE"))
        labels.append(addLabel(backgroundColor: .cyan, text: "ARE"))
        labels.append(addLabel(backgroundColor: .yellow, text: "SOME"))
        labels.append(addLabel(backgroundColor: .green, text: "AWESOME"))
        labels.append(addLabel(backgroundColor: .orange, text: "LABELS"))
        
        var previous: UILabel!
        for label in labels {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            if previous != nil {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
            }
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
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

