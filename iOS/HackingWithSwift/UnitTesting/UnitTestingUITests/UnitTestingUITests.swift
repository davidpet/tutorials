//
//  UnitTestingUITests.swift
//  UnitTestingUITests
//
//  Created by David Petrofsky on 11/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import XCTest

class UnitTestingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialStateIsCorrect() {
        let table = XCUIApplication().tables
        let cells = table.cells
        let count = cells.count
        XCTAssertEqual(count, 17, "There should be 17 rows initially")
    }
    
    func testUserFilteringByString() {
        let app = XCUIApplication()
        app.navigationBars["Shakespeare"].buttons["Filter"].tap()
        app.alerts["Filter"].collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("nes")
        app.typeText("s")
        app.buttons["OK"].tap()
        
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 word matching 'madness'")
    }
}
