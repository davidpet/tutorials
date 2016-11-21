//
//  GameScene.swift
//  CrashyPlane
//
//  Created by David Petrofsky on 11/20/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

//TODO: figure out why plane doesn't show up on Plus models (probably just cropped due to aspectFill)
class GameScene: SKScene {
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createPlayer()
        createSky()
        createBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func createPlayer() {
        //create the player at its position with initial graphic
        let playerTexture = SKTexture(imageNamed: "player-1")
        player = SKSpriteNode(texture: playerTexture)
        player.zPosition = 10       //position above other objects
        player.position = CGPoint(x: frame.width / 6, y: frame.height * 0.75)
        addChild(player)
        
        //set up the animation loop
        let frame2 = SKTexture(imageNamed: "player-2")
        let frame3 = SKTexture(imageNamed: "player-3")
        let animation = SKAction.animate(with: [playerTexture, frame2, frame3, frame2], timePerFrame: 0.01)
        let runForever = SKAction.repeatForever(animation)
        player.run(runForever)
    }
    
    func createSky() {
        //create two sky portions that divide the height of the screen (sky and background ground)
        let topSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.14, brightness: 0.97, alpha: 1),
                                  size: CGSize(width: frame.width, height: frame.height * 0.67))
        let bottomSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.16, brightness: 0.96, alpha: 1),
                                     size: CGSize(width: frame.width, height: frame.height * 0.33))
        
        //position the pieces of sky
        topSky.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottomSky.anchorPoint = CGPoint(x: 0.5, y: 1)
        topSky.position = CGPoint(x: frame.midX, y: frame.height)
        bottomSky.position = CGPoint(x: frame.midX, y: bottomSky.frame.height)
        
        //sky is the bottommost thing
        bottomSky.zPosition = -40
        topSky.zPosition = -40
        
        //add to the scene
        addChild(topSky)
        addChild(bottomSky)
    }
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "background")
        //create two background sprites from same background image
        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30      //above sky
            background.anchorPoint = CGPoint.zero   //position the background's bottom-left
            //position left so that they are overlapped by 1 point exactly
            //position top of both near bottom of screen
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 100)
            addChild(background)
        }
    }
}
