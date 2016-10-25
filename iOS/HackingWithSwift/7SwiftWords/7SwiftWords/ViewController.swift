//
//  ViewController.swift
//  7SwiftWords
//
//  Created by David Petrofsky on 10/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import GameplayKit

//possible improvements:
////take off points if they guess wrong
////don't allow the user to enter text directly
////handle the last level better
class ViewController: UIViewController {
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!

    var letterButtons = [UIButton]()
    var activatedBUttons = [UIButton]()
    var solutions = [String]()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        
        loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.characters.count)\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction!) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    func letterTapped(btn: UIButton) {
        currentAnswer.text  = currentAnswer.text! + btn.titleLabel!.text!
        activatedBUttons.append(btn)
        btn.isHidden = true
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedBUttons.removeAll()
            
            var splitClues = answersLabel.text!.components(separatedBy: "\n")
            splitClues[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitClues.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!",
                                           message: "Are you ready for the next level?",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!",
                                           style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: AnyObject) {
        currentAnswer.text = ""
        for btn in activatedBUttons {
            btn.isHidden = false
        }
        activatedBUttons.removeAll()
    }
}

