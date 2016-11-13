//
//  GameScene.swift
//  MarbleMaze
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let blockSize = 64
    
    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func loadLevel() {
        if let levelPath = Bundle.main.path(forResource: "level1", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath) {
                let lines = levelString.components(separatedBy: "\n")
                for (row, line) in lines.reversed().enumerated() {
                    for (column, letter) in line.characters.enumerated() {
                            let position = CGPoint(x: (blockSize * column) + blockSize / 2,
                                                   y: (blockSize * row) + blockSize / 2)
                            if letter == "x" {
                                // load wall
                            } else if letter == "v"  {
                                // load vortex
                            } else if letter == "s"  {
                                // load star
                            } else if letter == "f"  {
                                // load finish
                            }
                    }
                }
            }
        }
    }
}
