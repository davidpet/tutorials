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
class GameScene: SKScene, SKPhysicsContactDelegate {
    var backgroundMusic: SKAudioNode!
    
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        createPlayer()
        createSky()
        createBackground()
        createGround()
        createScore()
        
        startRocks()
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        if let musicURL = Bundle.main.url(forResource: "music", withExtension: "m4a") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //touching screen stops plane's downward motion and shoots it upward
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }
    
    override func update(_ currentTime: TimeInterval) {
        //rotate plane in direction of movement and speed
        let value = player.physicsBody!.velocity.dy * 0.001
        let rotate = SKAction.rotate(toAngle: value, duration: 0.1)
        player.run(rotate)
        //TODO: won't this create too many actions in the queue?
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //detect collision with invisible rectangle that comes after rocks
        if contact.bodyA.node?.name == "scoreDetect" || contact.bodyB.node?.name == "scoreDetect" {
            if contact.bodyA.node == player {
                contact.bodyB.node?.removeFromParent()      //remove rectangle
            } else {
                contact.bodyA.node?.removeFromParent()
            }
            
            //score point for the player
            let sound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
            run(sound)
            score += 1
            
            return
        }
        
        //detect collision with things besides score mark (ground and rocks)
        if contact.bodyA.node == player || contact.bodyB.node == player
        {
            //blow up the plane
            if let explosion = SKEmitterNode(fileNamed: "PlayerExplosion") {
                explosion.position = player.position
                addChild(explosion)
            }
            let sound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
            run(sound)
            
            //remove the player from the game
            player.removeFromParent()
            //stop the scrolling
            speed = 0
        }
    }
    
    func createPlayer() {
        //create the player at its position with initial graphic
        let playerTexture = SKTexture(imageNamed: "player-1")
        player = SKSpriteNode(texture: playerTexture)
        player.zPosition = 10       //position above other objects
        player.position = CGPoint(x: frame.width / 6, y: frame.height * 0.75)
        addChild(player)
        
        //set up the physics
        player.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerTexture.size())
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        player.physicsBody?.isDynamic = true
        player.physicsBody?.collisionBitMask = 0
        
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
            
            //set up the infinite scrolling of the background
            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            background.run(moveForever)
        }
    }
    
    func createGround() {
        let groundTexture = SKTexture(imageNamed: "ground")
        //create two ground sprites from same ground image
        for i in 0 ... 1 {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.zPosition = -10  //above background
            //position at bottom of screen with pieces not overlapping
            ground.position = CGPoint(x: (groundTexture.size().width / 2.0 + (groundTexture.size().width * CGFloat(i))),
                                      y: groundTexture.size().height / 2)
            //set up ground physics
            ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.texture!.size())
            ground.physicsBody?.isDynamic = false
            //add to scene
            addChild(ground)
            
            //set up infinite scrolling of ground (faster than background)
            let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
            let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            ground.run(moveForever)
        }
    }
    
    //start a loop of creating rocks every 3 seconds
    func startRocks() {
        let create = SKAction.run { [unowned self] in
            self.createRocks()
        }
        let wait = SKAction.wait(forDuration: 3)
        let sequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
    }
    
    //create one set of rocks to scroll across screen and die
    func createRocks() {
        //create two rocks in between ground and background
        let rockTexture = SKTexture(imageNamed: "rock")
        let topRock = SKSpriteNode(texture: rockTexture)
        topRock.physicsBody = SKPhysicsBody(texture: rockTexture, size: rockTexture.size())
        topRock.physicsBody?.isDynamic = false
        topRock.zRotation = CGFloat.pi
        topRock.xScale = -1.0
        let bottomRock = SKSpriteNode(texture: rockTexture)
        bottomRock.physicsBody = SKPhysicsBody(texture: rockTexture, size: rockTexture.size())
        bottomRock.physicsBody?.isDynamic = false
        topRock.zPosition = -20
        bottomRock.zPosition = -20
        
        //create a region to track when user has passed rocks (and add the rocks and region to the scene)
        let rockCollision = SKSpriteNode(color: UIColor.red, size: CGSize(width: 32, height: frame.height))
        rockCollision.physicsBody = SKPhysicsBody(rectangleOf: rockCollision.size)
        rockCollision.physicsBody?.isDynamic = false
        rockCollision.name = "scoreDetect"
        addChild(topRock)
        addChild(bottomRock)
        addChild(rockCollision)
        
        //pick a randomly positioned (but certain size) gap between the rocks
        let xPosition = frame.width + topRock.frame.width
        let max = Int(frame.height / 3)
        let rand = GKRandomDistribution(lowestValue: -100, highestValue: max)
        let yPosition = CGFloat(rand.nextInt())
        // this next value affects the width of the gap between rocks
        // make it smaller to make your game harder – if you're feeling evil!
        let rockDistance: CGFloat = 70
        
        //position the rocks offscreen according to the gap
        topRock.position = CGPoint(x: xPosition, y: yPosition + topRock.size.height + rockDistance)
        bottomRock.position = CGPoint(x: xPosition, y: yPosition - rockDistance)
        //position the collision after the rocks
        rockCollision.position = CGPoint(x: xPosition + (rockCollision.size.width * 2), y: frame.midY)
        let endPosition = frame.width + (topRock.frame.width * 2)
        
        //animate both rocks and collision bar moving together to left edge of screen and dissappearing
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6.2)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        topRock.run(moveSequence)
        bottomRock.run(moveSequence)
        rockCollision.run(moveSequence)
    }
    
    func createScore() {
        scoreLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x: frame.maxX - 20, y: frame.maxY - 40)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontColor = UIColor.black
        addChild(scoreLabel)
    }
}
