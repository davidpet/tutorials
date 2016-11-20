//
//  GameScene.swift
//  CrashyPlane
//
//  Created by David Petrofsky on 11/20/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func createPlayer() {
        //create the player at its position with initial graphic
        let playerTexture = SKTexture(imageNamed: "player-1")
        player = SKSpriteNode(texture: playerTexture)
        player.zPosition = 10
        player.position = CGPoint(x: frame.width / 6, y: frame.height * 0.75)
        addChild(player)
        
        //set up the animation loop
        let frame2 = SKTexture(imageNamed: "player-2")
        let frame3 = SKTexture(imageNamed: "player-3")
        let animation = SKAction.animate(with: [playerTexture, frame2, frame3, frame2], timePerFrame: 0.01)
        let runForever = SKAction.repeatForever(animation)
        player.run(runForever)
    }
}
