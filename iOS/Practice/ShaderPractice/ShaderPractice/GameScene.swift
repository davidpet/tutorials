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
        shaders.append(SKShader(fileNamed: "shader2"))
        let shader3 = SKShader(fileNamed: "shader3")
        shader3.uniforms = [
            SKUniform(name: "u_gradient", texture: SKTexture(imageNamed: "shieldmask")),
            SKUniform(name: "u_health", float: 0.75)
        ]
        shaders.append(shader3)
        
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
