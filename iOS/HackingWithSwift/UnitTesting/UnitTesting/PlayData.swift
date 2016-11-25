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
    var uniqueWords: NSCountedSet!
    var filter: String?
    var filteredWords: [String]  = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != "" }
                
                uniqueWords = NSCountedSet(array: allWords)
                let sorted = uniqueWords.allObjects.sorted { uniqueWords.count(for: $0) > uniqueWords.count(for: $1) }
                allWords = sorted as! [String]
                
                filteredWords = allWords
            }
        }
    }
    
    func filter(_ filterText: String) {
        filteredWords = allWords.filter {$0.contains(filterText)}
        filter = filterText
    }
}
