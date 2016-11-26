//
//  ViewController.swift
//  MyPracticeApp
//
//  Created by David Petrofsky on 11/25/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func actionTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Action", message: "Pick an action", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Action1", style: .default))
        ac.addAction(UIAlertAction(title: "Action2", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func alertTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Alert", message: "Pick an action", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Alert1", style: .default))
        ac.addAction(UIAlertAction(title: "Alert2", style: .default))
        present(ac, animated: true)
    }
}

