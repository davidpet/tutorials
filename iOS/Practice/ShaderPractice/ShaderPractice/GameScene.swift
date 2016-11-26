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
    var shield: SKSpriteNode!
    var shaders = [SKShader?]()
    var currentShader = 0
    
    override func didMove(to view: SKView) {
        let shield = SKSpriteNode(imageNamed: "Shield")
        shield.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(shield)
        self.shield = shield
        
        shaders.append(nil)
        shaders.append(SKShader(fileNamed: "shader1"))
        
        shield.shader = shaders[currentShader]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentShader += 1
        if currentShader >= shaders.count {
            currentShader = 0
        }
        shield.shader = shaders[currentShader]
    }
}
