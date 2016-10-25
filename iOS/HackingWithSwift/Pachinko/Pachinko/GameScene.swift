//
//  GameScene.swift
//  Pachinko
//
//  Created by David Petrofsky on 10/25/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with
        event: UIEvent?) {
    }
}
