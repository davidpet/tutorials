//
//  ViewController.swift
//  Animation
//
//  Created by David Petrofsky on 10/28/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tap: UIButton!
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)

    }

    @IBAction func tapped(_ sender: AnyObject) {
        currentAnimation = (currentAnimation + 1) % 8
    }
}

