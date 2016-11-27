//
//  GameScene.swift
//  DiscoShader
//
//  Created by David Petrofsky on 11/27/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let discoBall = SKSpriteNode(color: .clear, size: CGSize(width: frame.width, height: frame.height))
        discoBall.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        discoBall.shader = SKShader(fileNamed: "DiscoBall")
        addChild(discoBall)
        
        discoBall.shader!.uniforms = [SKUniform(name: "u_aspect", float: Float(frame.width / frame.height))]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
