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
        //XCTAssertEqual(detailText.label, "4/150")
        XCTAssertEqual(detailText.label, "7/150")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "8/150")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "9/150")
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
        
        let backButton = app.buttons["Inventory"]
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
        
        let backButton = app.buttons["Inventory"]
        backButton.tap()
        
        let secondEntry = app.collectionViews.buttons.element(boundBy: 1)
        secondEntry.tap()
        
        XCTAssertEqual(favouriteToggle.value as? String, "0")
    }
    
    func testAddItem() throws{
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        app.collectionViews.buttons.firstMatch.tap()
        let detailTextEditor = app.textViews["DetailTextEditor"]
        // What if I want to check the image, row, object size?
        XCTAssertEqual(detailTextEditor.value as? String, "Ladybug")
    }
    
    func testDeleteItem() throws{
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()
        XCTAssertEqual(app.collectionViews.buttons.count as? Int, 1)
    }
    
    func testLoadSaveItem() throws{
        let app = XCUIApplication()
        app.launch()
        
        //add first item
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        app.collectionViews.buttons.firstMatch.tap()
        
        let favouriteToggle = app.switches["FavouriteToggle"]
        favouriteToggle.tap()
        
        let backButton = app.buttons["Inventory"]
        backButton.tap()
        
        //add second item
        app.navigationBars["Inventory"].buttons["PlusButton"].tap()
        
        XCUIDevice.shared.press(.home)
        sleep(1)
        
        app.terminate()
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        
        backButton.tap()
        
        app.collectionViews.buttons.element(boundBy: 1).tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        
        backButton.tap()
        //remove 2 items
        /*
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()
        app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
        app.collectionViews.buttons["Delete"].tap()
         */
        
        //remove items util got 2 items left
        let defaultItems = 2
        while (app.collectionViews.buttons.count > defaultItems){
            app.collectionViews.buttons.firstMatch.swipeLeft(velocity: .slow)
            app.collectionViews.buttons["Delete"].tap()
        }
        XCUIDevice.shared.press(.home)
        sleep(1)
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
