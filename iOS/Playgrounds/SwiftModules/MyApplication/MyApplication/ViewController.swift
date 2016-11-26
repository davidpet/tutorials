//
//  ViewController.swift
//  MyApplication
//
//  Created by David Petrofsky on 10/31/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import MyLibrary
//import GameplayKit  //did not get imported via MyLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let m = MyStruct(x: 5)
        
        _ = GKRandomSource.self
        _ = gk
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

