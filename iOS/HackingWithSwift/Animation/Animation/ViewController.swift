//
//  ViewController.swift
//  Animation
//
//  Created by David Petrofsky on 10/28/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tap: UIButton!
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        view.addSubview(imageView)

    }

    @IBAction func tapped(_ sender: AnyObject) {
        tap.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                       animations: { [unowned self] in
                        switch self.currentAnimation {
                        case 0:
                            self.imageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                        case 1:
                            self.imageView.transform = CGAffineTransform.identity
                        case 2:
                            let delta = -(self.view.frame.width / 6)
                            self.imageView.transform = CGAffineTransform(translationX: delta, y: delta)
                        case 3:
                            self.imageView.transform = CGAffineTransform.identity
                        case 4:
                            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        case 5:
                            self.imageView.transform = CGAffineTransform.identity
                        case 6:
                            self.imageView.backgroundColor = UIColor.green
                            self.imageView.alpha = 0.1
                        case 7:
                            self.imageView.backgroundColor = UIColor.clear
                            self.imageView.alpha = 1
                        default:
                            break
                        }
        }) { [unowned self] (finished: Bool) in
            self.tap.isHidden = false
        }
        
        currentAnimation = (currentAnimation + 1) % 8
    }
}

