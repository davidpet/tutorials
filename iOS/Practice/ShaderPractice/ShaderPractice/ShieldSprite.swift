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
    //MARK: Static Variables
    public static let nodeName = "Shield"
    
    private static let texture = SKTexture(imageNamed: "Shield")
    private static let maskTexture = SKTexture(imageNamed: "shieldmask")
    
    private static let shaders: [SKShader?] = makeShaders()
    private static let uniforms = [
        SKUniform(name: "u_gradient", texture: SKTexture(imageNamed: "shieldmask")),
        SKUniform(name: "u_health", float: 0.75),
        SKUniform(name: "u_size", vectorFloat2: vector_float2([Float(texture.size().width /** UIScreen.main.scale*/),
                                                               Float(texture.size().height /** UIScreen.main.scale*/)]))
    ]
    
    //MARK: Configuration
    private static let shadersWithUniforms = [3, 4, 5, 7, 8]
    private static let lastShader = 8
    
    //MARK Private Variables
    private var currentShader = 0
    private var shield: SKSpriteNode!
    
    //MARK: Static Methods
    private static func makeShaders() -> [SKShader?] {
        var shaders = [SKShader?]()
        shaders.append(nil)
        
        (1...lastShader).forEach { shaders.append(makeShader($0, withUniforms: shadersWithUniforms.contains($0))) }
        
        return shaders
    }
    
    private static func makeShader(_ num: Int, withUniforms: Bool) -> SKShader {
        let shader = SKShader(fileNamed: "shader\(num)")
        if withUniforms {
            shader.uniforms = ShieldSprite.uniforms
        }
        
        return shader
    }
    
    //MARK: Constructors
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
    
    //MARK: Public Methods
    public func advanceShader() {
        currentShader = (currentShader + 1) % ShieldSprite.shaders.count
        
        shield.shader = ShieldSprite.shaders[currentShader]
    }
}
