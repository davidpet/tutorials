//
//  ShieldSprite.swift
//  ShaderPractice
//
//  Created by David Petrofsky on 11/26/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import SpriteKit

class ShieldSprite: SKNode {
    public static let nodeName = "Shield"
    
    private static let texture = SKTexture(imageNamed: "Shield")
    private static let maskTexture = SKTexture(imageNamed: "shieldmask")
    
    private static let shaders: [SKShader?] = makeShaders()
    
    private var currentShader = 0
    private var shield: SKSpriteNode!
    
    private static func makeShaders() -> [SKShader?] {
        var shaders = [SKShader?]()
        
        shaders.append(nil)
        shaders.append(SKShader(fileNamed: "shader1"))
        shaders.append(SKShader(fileNamed: "shader2"))
        let pixelSize = vector_float2([Float(texture.size().width /** UIScreen.main.scale*/),
                                       Float(texture.size().height /** UIScreen.main.scale*/)])
        let uniforms = [
            SKUniform(name: "u_gradient", texture: SKTexture(imageNamed: "shieldmask")),
            SKUniform(name: "u_health", float: 0.75),
            SKUniform(name: "u_size", vectorFloat2: pixelSize)
        ]
        let shader3 = SKShader(fileNamed: "shader3")
        shader3.uniforms = uniforms
        shaders.append(shader3)
        let shader4 = SKShader(fileNamed: "shader4")
        shader4.uniforms = uniforms
        shaders.append(shader4)
        let shader5 = SKShader(fileNamed: "shader5")
        shader5.uniforms = uniforms
        shaders.append(shader5)

        return shaders
    }
    
    public init(at position: CGPoint) {
        super.init()
        self.position = position
        self.name = ShieldSprite.nodeName
        
        shield = SKSpriteNode(texture: ShieldSprite.texture)
        addChild(shield)
        
        shield.shader = ShieldSprite.shaders[currentShader]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func advanceShader() {
        currentShader = (currentShader + 1) % ShieldSprite.shaders.count
        
        shield.shader = ShieldSprite.shaders[currentShader]
    }
}
