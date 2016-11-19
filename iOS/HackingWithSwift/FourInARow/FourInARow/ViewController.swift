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

    var placedChips = [[UIView]]()      //[column][row] order
    var board: Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< Board.width {
            placedChips.append([UIView]())
        }
        
        resetBoard()
    }
    
    func resetBoard() {
        board = Board()
        
        for i in 0..<placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    @IBAction func makeMove(_ sender: UIButton) {
    }
}

