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
        addChild(ShieldSprite(at: CGPoint(x: frame.width / 2, y: frame.height / 2)))
        addChild(ShieldSprite(at: CGPoint(x: frame.width / 3, y: frame.height / 2)))
        addChild(ShieldSprite(at: CGPoint(x: frame.width * 2 / 3, y: frame.height / 2)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = touches.first?.location(in: self) {
            for node in nodes(at: position) {
                if node.name == ShieldSprite.nodeName {
                    (node as! ShieldSprite).advanceShader()
                }
            }
        }
    }
}
