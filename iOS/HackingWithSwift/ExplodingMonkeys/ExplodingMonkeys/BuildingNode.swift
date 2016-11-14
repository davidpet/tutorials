//
//  BuildingNode.swift
//  ExplodingMonkeys
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import SpriteKit
import UIKit
import GameplayKit

class BuildingNode: SKSpriteNode {
    var currentImage: UIImage!

    func setup() {
        name = "building"
        currentImage = drawBuilding(size: size)
        texture = SKTexture(image: currentImage)
        configurePhysics()
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = CollisionTypes.building.rawValue
        physicsBody!.contactTestBitMask = CollisionTypes.banana.rawValue
    }
    
    func drawBuilding(size: CGSize) -> UIImage {
        //use CoreGraphics for rendering
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            //draw base rectangle of random color
            let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            var color: UIColor
            switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
            case 0:
                color = UIColor(hue: 0.502, saturation: 0.98, brightness: 0.67, alpha: 1)
            case 1:
                color = UIColor(hue: 0.999, saturation: 0.99, brightness: 0.67, alpha: 1)
            default:
                color = UIColor(hue: 0, saturation: 0, brightness: 0.67, alpha: 1)
            }
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fill)
            
            //draw random window grid (on/off randomized) within the building rectangle
            let lightOnColor = UIColor(hue: 0.190, saturation: 0.67, brightness: 0.99, alpha: 1)
            let lightOffColor = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1)
    
            for row in stride(from: 10, to: Int(size.height - 10), by: 40) {
                for col in stride(from: 10, to: Int(size.width - 10), by: 40) {
                    if RandomInt(min: 0, max: 1) == 0 {
                        ctx.cgContext.setFillColor(lightOnColor.cgColor)
                    } else {
                        ctx.cgContext.setFillColor(lightOffColor.cgColor)
                    }
                    ctx.cgContext.fill(CGRect(x: col, y: row, width: 15, height: 20))
                }
            }
        }
        return img
    }
}
