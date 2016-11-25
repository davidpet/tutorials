//
//  PlayData.swift
//  UnitTesting
//
//  Created by David Petrofsky on 11/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import Foundation

class PlayData {
    var allWords = [String]()
    var uniqueWords = [String:Int]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != "" }
                
                for word in allWords {
                    if uniqueWords[word] == nil {
                        uniqueWords[word] = 1
                    } else {
                        uniqueWords[word]! += 1
                    }
                }
                
                allWords = Array(uniqueWords.keys)
            }
        }
    }
}
