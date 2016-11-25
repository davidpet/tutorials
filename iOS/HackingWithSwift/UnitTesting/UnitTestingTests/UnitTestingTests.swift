//
//  UnitTestingTests.swift
//  UnitTestingTests
//
//  Created by David Petrofsky on 11/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import XCTest
@testable import UnitTesting

class UnitTestingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllWordsLoaded() {
        let playData = PlayData()
        XCTAssertEqual(playData.allWords.count, 18440, "allWords was not 18440")
    }
    
    func testWordCountsAreCorrect() {
        let playData = PlayData()
        XCTAssertEqual(playData.uniqueWords["home"], 174, "Home does not appear 174 times")
        XCTAssertEqual(playData.uniqueWords["fun"], 4, "Fun does not appear 4 times")
        XCTAssertEqual(playData.uniqueWords["mortal"], 41, "Mortal does not appear 41 times")
    }
}
