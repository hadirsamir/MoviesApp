//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import XCTest

class MoviesAppUITests: XCTestCase {
   var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFieldsdata(){
        let expect = expectation(description: "Get Data Succeded")
        let titleText = "Spider Man"
        let overViewText = "Hello There"

        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".otherElements[\"My Movies\"].buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
       let titleTextField = app.textFields["Title"]
        XCTAssertTrue(titleTextField.exists)
       titleTextField.tap()
       titleTextField.typeText(titleText)

        let textView = app.otherElements.containing(.navigationBar, identifier:"My Movie").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
         XCTAssertTrue(textView.exists)
        textView.tap()
        textView.typeText(overViewText)


        app.buttons["Add Movie"].tap()
        
        let table = app.tables.element
        XCTAssertTrue(table.exists)
        
        let cell = table.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists)
        let indexedText = cell.staticTexts.element
        XCTAssertTrue(indexedText.exists)
        expect.fulfill()
        
        waitForExpectations(timeout: 50, handler: nil)
        //XCTAssertTrue( cellData.exists)

    }

}

