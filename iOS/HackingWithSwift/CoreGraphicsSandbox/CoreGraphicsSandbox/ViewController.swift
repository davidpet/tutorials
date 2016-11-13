//
//  ViewController.swift
//  CoreGraphicsSandbox
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIButton!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    func drawRectangle() {
        
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        switch currentDrawType {
        case 0:
            drawRectangle()
        default:
            break
        }
    }
}

