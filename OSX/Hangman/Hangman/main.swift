//
//  main.swift
//  Hangman
//
//  Created by David Petrofsky on 11/12/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import Foundation

let word = "RHYTHM"
var usedLetters = [Character]()

print("Welcome to Hangman!")
print("Press a letter to guess, or Ctrl+D to quit.")

func printWord() {
    print("\nWord: ", terminator: "")
    var missingLetters = false
    
    for letter in word.characters {
        if usedLetters.contains(letter) {
            print(letter, terminator: "")
        } else {
            print("_", terminator: "")
            missingLetters = true
        }
    }
}

printWord()
