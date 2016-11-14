//
//  GameViewController.swift
//  ExplodingMonkeys
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerNumber: UILabel!
    
    var currentGame: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                //wire the controller and scene together
                currentGame = scene as! GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func launch(_ sender: UIButton) {
    }
    
    @IBAction func angleChanged(_ sender: UISlider) {
    }
    
    @IBAction func velocityChanged(_ sender: UISlider) {
    }
}
