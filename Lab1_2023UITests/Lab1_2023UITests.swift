//
//  Lab1_2023UITests.swift
//  Lab1_2023UITests
//
//  Created by IMD 224 on 2023-01-10.
//

import XCTest

final class Lab1_2023UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharCount() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        
        let detailText = app.staticTexts["DetailText"]
        XCTAssertEqual(detailText.label, "4/150")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "5/150")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "6/150")
    }
    
    func testTextEntering() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        keyH.tap()
        
        let keyi = app.keys["a"]
        for _ in 1...155 {
            keyi.tap()
        }
        
    }
    
    func testMaxCharsStepper() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        let toggle = app.buttons["NavigationButton"]
        toggle.tap()
        
        for _ in 1...33 {
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
        
        app.terminate()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        
        let detailText = app.staticTexts["DetailText"]
        //Checks that the maximum character is still 300
        //XCTAssertEqual(detailText.label, "0/10")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyY = app.keys["Y"]
        keyY.tap()
        
        let keya = app.keys["a"]
        for _ in 1...12 {
            keya.tap()
        }
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        
        // Check to make sure that the maximumcharacter count to 300
        toggle.tap()
        for _ in 1...33 {
            app.steppers["MaxCountStepper"].buttons["Increment"].tap()
        }
        
        for _ in 1...15 {
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
    }
    
    func testToggle() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        
        let favouriteToggle = app.switches["FavouriteToggle"]
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        
        let secondEntry = app.collectionViews.buttons.element(boundBy: 1)
        secondEntry.tap()
        
        XCTAssertEqual(favouriteToggle.value as? String, "0")
    }
    
    

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
