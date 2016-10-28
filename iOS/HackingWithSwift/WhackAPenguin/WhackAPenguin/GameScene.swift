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
    var popupTime = 0.85
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.createEnemy()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            for node in tappedNodes {
                let isFriend: Bool
                if node.name == "charFriend" { isFriend = true }
                else if node.name == "charEnemy" { isFriend = false }
                else { continue }
                
                let whackSlot = node.parent!.parent as! WhackSlot
                if !whackSlot.isVisible { continue }
                if whackSlot.isHit { continue }
                
                whackSlot.hit()
                
                var soundName: String
                if isFriend {
                    score -= 5
                    soundName = "whackBad.caf"
                } else {
                    score += 1
                    soundName = "whack.caf"
                    
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                }
                
                run(SKAction.playSoundFileNamed(soundName, waitForCompletion:false))
            }
        }
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
    
    func createEnemy() {
        popupTime *= 0.991
        
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: slots) as! [WhackSlot]
        
        slots[0].show(hideTime: popupTime)
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 8 {  slots[2].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime)  }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = RandomDouble(min: minDelay, max: maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }
}
