//
//  main.swift
//  Hangman
//
//  Created by David Petrofsky on 11/12/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import Foundation

let word = "RHYTHM"
let guessesAllowed = 8
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
    
    print("\nGuesses: \(usedLetters.count)/\(guessesAllowed)")
    if missingLetters == false {
        //win
        print("It looks like you live on... for now.")
        exit(0)
    } else {
        if usedLetters.count == guessesAllowed {
            //lose
            print("Oops – you died! The word was \(word).")
            exit(0)
        } else {
            //another round
            print("Enter a guess: ", terminator: "")
        }
    }
}

printWord()
while var input = readLine() {
    if let letter = input.uppercased().characters.first {
        if usedLetters.contains(letter) {
            print("You used that letter already!")
        } else {
            usedLetters.append(letter)
        }
    }
    
    printWord()
}

print("\nThanks for playing!")
