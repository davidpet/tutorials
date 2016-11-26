//
//  GameScene.swift
//  ShaderPractice
//
//  Created by David Petrofsky on 11/26/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let shield = SKSpriteNode(imageNamed: "Shield")
        shield.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(shield)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
