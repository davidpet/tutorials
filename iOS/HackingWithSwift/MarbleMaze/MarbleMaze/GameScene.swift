//
//  GameScene.swift
//  MarbleMaze
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
}

class GameScene: SKScene {
    let blockSize = 64
    
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        loadLevel()
        createPlayer()
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: Int(1.5*Double(blockSize)), y: Int(10.5*Double(blockSize)))
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.linearDamping = 0.5
        player.physicsBody!.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody!.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue |
                                                 CollisionTypes.finish.rawValue
        player.physicsBody!.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    func loadLevel() {
        if let levelPath = Bundle.main.path(forResource: "level1", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath) {
                let lines = levelString.components(separatedBy: "\n")
                for (row, line) in lines.reversed().enumerated() {
                    for (column, letter) in line.characters.enumerated() {
                            let position = CGPoint(x: (blockSize * column) + blockSize / 2,
                                                   y: (blockSize * row) + blockSize / 2)
                            if letter == "x" {
                                let node = SKSpriteNode(imageNamed: "block")
                                node.position = position
                                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                                node.physicsBody!.categoryBitMask = CollisionTypes.wall.rawValue
                                node.physicsBody!.isDynamic = false
                                addChild(node)
                            } else if letter == "v"  {
                                let node = SKSpriteNode(imageNamed: "vortex")
                                node.name = "vortex"
                                node.position = position
                                node.run(SKAction.repeatForever(SKAction.rotate(byAngle:
                                    CGFloat.pi, duration: 1)))
                                node.physicsBody = SKPhysicsBody(circleOfRadius:
                                    node.size.width / 2)
                                node.physicsBody!.isDynamic = false
                                node.physicsBody!.categoryBitMask = CollisionTypes.vortex.rawValue
                                node.physicsBody!.contactTestBitMask = CollisionTypes.player.rawValue
                                node.physicsBody!.collisionBitMask = 0
                                addChild(node)
                                
                            } else if letter == "s"  {
                                let node = SKSpriteNode(imageNamed: "star")
                                node.name = "star"
                                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                                node.physicsBody!.isDynamic = false
                                node.physicsBody!.categoryBitMask = CollisionTypes.star.rawValue
                                node.physicsBody!.contactTestBitMask = CollisionTypes.player.rawValue
                                node.physicsBody!.collisionBitMask = 0
                                node.position = position
                                addChild(node)
                            } else if letter == "f"  {
                                let node = SKSpriteNode(imageNamed: "finish")
                                node.name = "finish"
                                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                                node.physicsBody!.isDynamic = false
                                node.physicsBody!.categoryBitMask = CollisionTypes.finish.rawValue
                                node.physicsBody!.contactTestBitMask = CollisionTypes.player.rawValue
                                node.physicsBody!.collisionBitMask = 0
                                node.position = position
                                addChild(node)
                            }
                    }
                }
            }
        }
    }
}
