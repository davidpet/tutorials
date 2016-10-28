//
//  GameScene.swift
//  WhackAPenguin
//
//  Created by David Petrofsky on 10/27/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var slots = [WhackSlot]()
    var gameScore: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        score = 0
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        createSlotRow(with: 5, startingAt: CGPoint(x: 100, y: 410))
        createSlotRow(with: 4, startingAt: CGPoint(x: 180, y: 320))
        createSlotRow(with: 5, startingAt: CGPoint(x: 100, y: 230))
        createSlotRow(with: 4, startingAt: CGPoint(x: 180, y: 140))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        
        addChild(slot)
        slots.append(slot)
    }
    
    func createSlotRow(with numSlots: Int, startingAt position: CGPoint) {
        for i in 0 ..< numSlots {
            let x = Int(position.x) + i * 170
            createSlot(at: CGPoint(x: CGFloat(x), y: position.y))
        }
    }
}
