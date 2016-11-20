//
//  ViewController.swift
//  FourInARow
//
//  Created by David Petrofsky on 11/19/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    @IBOutlet var columnButtons: [UIButton]!

    var placedChips = [[UIView]]()      //[column][row] order
    var board: Board!
    
    var strategist: GKMinmaxStrategist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< Board.width {
            placedChips.append([UIView]())
        }
        
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 7
        strategist.randomSource = nil
        
        resetBoard()
    }
    
    func resetBoard() {
        board = Board()
        strategist.gameModel = board
        updateUI()
        
        for i in 0..<placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    func addChip(inColumn column: Int, row: Int, color: UIColor) {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        if (placedChips[column].count < row + 1) {
            let newChip = UIView()
            newChip.frame = rect
            newChip.isUserInteractionEnabled = false
            newChip.backgroundColor = color
            newChip.layer.cornerRadius = size / 2
            newChip.center = positionForChip(inColumn: column, row: row)
            newChip.transform = CGAffineTransform(translationX: 0, y: -800)
            view.addSubview(newChip)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    newChip.transform = CGAffineTransform.identity
            })
            placedChips[column].append(newChip)
        }
    }
    
    func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let xOffset = button.frame.midX
        var yOffset = button.frame.maxY - size / 2
        yOffset -= size * CGFloat(row)
        return CGPoint(x: xOffset, y: yOffset)
    }
    
    //called at end of each move, so calling at end of red move triggers a UI move which will trigger this again with red
    func updateUI() {
        title = "\(board.currentPlayer.name)'s Turn"
        
        if board.currentPlayer.chip == .black {
            startAIMove()
        }
        
    }
    
    func continueGame() {
        var gameOverTitle: String? = nil
        //detect win or draw
        if board.isWin(for: board.currentPlayer) {
            gameOverTitle = "\(board.currentPlayer.name) Wins!"
        } else if board.isFull() {
            gameOverTitle = "Draw!"
        }
        
        //handle win or draw if one was detected
        if gameOverTitle != nil {
            let alert = UIAlertController(title: gameOverTitle,
                                          message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Play Again",
                                            style: .default) { [unowned self] (action) in
                                                self.resetBoard()
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }

        //next turn (either in this game or next game)
        board.currentPlayer = board.currentPlayer.opponent
        updateUI()
    }
    
    //perform an AI move with appropriate delay to make it look like a player
    func startAIMove() {
        //put the UI into "thinking" mode
        columnButtons.forEach { $0.isEnabled = false }
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)

        //do the actual thinking/moving (makeAIMove will restore the UI from thinking mode)
        DispatchQueue.global().async { [unowned self] in
            let strategistTime = CFAbsoluteTimeGetCurrent()
            let column = self.columnForAIMove()!            //the actual AI calculation
            let delta = CFAbsoluteTimeGetCurrent() - strategistTime
            
            let aiTimeCeiling = 1.0
            let delay = min(aiTimeCeiling - delta, aiTimeCeiling)       //this doesn't seem right, what if it's negative?
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.makeAIMove(in: column)
            }
        }
    }
    
    //our wrapper for calculating the next move from the AI (intense work done)
    func columnForAIMove() -> Int? {
        if let aiMove = strategist.bestMove(for: board.currentPlayer) as? Move {
            return aiMove.column
        }
        return nil
    }
    
    //this is basically duplicated with makeMove() but takes a column instead of button click
    //TODO: refactor so that makeMove calls this
    func makeAIMove(in column: Int) {
        //take the UI out of "thinking" mode
        columnButtons.forEach { $0.isEnabled = true }
        navigationItem.leftBarButtonItem = nil
        
        //udpate the state
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: board.currentPlayer.chip, in: column)
            addChip(inColumn: column, row:row, color: board.currentPlayer.color)
            continueGame()
        }
    }
    
    @IBAction func makeMove(_ sender: UIButton) {
        let column = sender.tag
        
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: board.currentPlayer.chip, in: column)
            addChip(inColumn: column, row: row, color:
                board.currentPlayer.color)
            continueGame()
        }
    }
}

