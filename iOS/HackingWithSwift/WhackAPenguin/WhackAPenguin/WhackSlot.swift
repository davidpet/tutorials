//
//  WhackSlot.swift
//  WhackAPenguin
//
//  Created by David Petrofsky on 10/27/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
    }
}
