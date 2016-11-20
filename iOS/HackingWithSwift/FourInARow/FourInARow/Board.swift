//
//  Board.swift
//  FourInARow
//
//  Created by David Petrofsky on 11/19/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import GameplayKit

enum ChipColor: Int {
    case none = 0
    case red
    case black
}

class Board: NSObject, GKGameModel {
    static var width = 7
    static var height = 6
    
    var slots = [ChipColor]()   //column-major ordering (column * height + row) [rows go from bottom up]
    var currentPlayer: Player
    
    //GameplayKit: get list of players
    var players: [GKGameModelPlayer]? {
        return Player.allPlayers
    }
    
    //GameplayKit: get current player
    var activePlayer: GKGameModelPlayer? {
        return currentPlayer
    }
    
    override init() {
        for _ in 0 ..< Board.width * Board.height {
            slots.append(.none)
        }
        currentPlayer = Player.allPlayers[0]
        
        super.init()
    }
    
    //NSCopying: fully clone the board
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board()
        copy.setGameModel(self)
        
        return copy
    }
    
    //Gameplay Kit: set board state based on an existing board
    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            slots = board.slots
            currentPlayer = board.currentPlayer
        }
    }
    
    //Gameplay Kit: possible moves for the given player in the given board state
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        if let playerObject = player as? Player {
            if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
                return nil
            }

            var moves = [Move]()
            for column in 0 ..< Board.width {
                if canMove(in: column) {
                    moves.append(Move(column: column))
                }
            }

            return moves
        }
        
        return nil
    }
    
    //Gameplay Kit: update the board state based on a given move
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let move = gameModelUpdate as? Move {
            add(chip: currentPlayer.chip, in: move.column)
            currentPlayer = currentPlayer.opponent
        }
    }
    
    //Gameplay Kit: get a score of how good the current board state is for the given player
    func score(for player: GKGameModelPlayer) -> Int {
        if let playerObject = player as? Player {
            if isWin(for: playerObject) {
                return 1000
            } else if isWin(for: playerObject.opponent) {
                return -1000
            }
        }
        return 0
    }
    
    //Gameplay Kit: calculate whether the current board state is a win for the given player
    func isWin(for player: GKGameModelPlayer) -> Bool {
        let chip = (player as! Player).chip
        //brute force: check each cell for a win in each direction
        //even though only checks 4 directions, since checking every cell, it covers all the 8 neighbor lines
        for row in 0 ..< Board.height {
            for col in 0 ..< Board.width {
                if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 0) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 0, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: -1) {
                    return true
                }
            }
        }
        return false
    }
    
    func chip(inColumn column: Int, row: Int) -> ChipColor {
        return slots[row + column * Board.height]
    }
    
    func set(chip: ChipColor, in column: Int, row: Int) {
        slots[row + column * Board.height] = chip
    }
    
    func nextEmptySlot(in column: Int) -> Int? {
        for row in 0 ..< Board.height {
            if chip(inColumn: column, row: row) == .none {
                return row
            }
        }
        return nil
    }
    
    func canMove(in column: Int) -> Bool {
        return nextEmptySlot(in: column) != nil
    }
    
    func add(chip: ChipColor, in column: Int) {
        if let row = nextEmptySlot(in: column) {
            set(chip: chip, in: column, row: row)
        }
    }
    
    func isFull() -> Bool {
        for column in 0 ..< Board.width {
            if canMove(in: column) {
                return false
            }
        }
        
        return true
    }
    
    //check for four from (row,col) to (row+movY*3, col+movX*3) of the proper color
    //safe to call on edges
    func squaresMatch(initialChip: ChipColor, row: Int, col: Int, moveX: Int, moveY: Int) -> Bool {
        // bail out early if we can't win from here
        if row + (moveY * 3) < 0 { return false }
        if row + (moveY * 3) >= Board.height { return false }
        if col + (moveX * 3) < 0 { return false }
        if col + (moveX * 3) >= Board.width { return false }
        // still here? Check every square
        if chip(inColumn: col, row: row) != initialChip { return false }
        if chip(inColumn: col + moveX, row: row + moveY) != initialChip { return false }
        if chip(inColumn: col + (moveX * 2), row: row + (moveY * 2)) != initialChip { return false }
        if chip(inColumn: col + (moveX * 3), row: row + (moveY * 3)) != initialChip { return false }
        //if we make it here, this is a match
        return true
    }
}
