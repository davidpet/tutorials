//
//  ViewController.swift
//  FourInARow
//
//  Created by David Petrofsky on 11/19/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var columnButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func makeMove(_ sender: UIButton) {
    }
}

