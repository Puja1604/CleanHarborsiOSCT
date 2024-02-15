//
//  CleanHarborsiOSCTUITests.swift
//  CleanHarborsiOSCTUITests
//
//  Created by Puja Gogineni on 2/15/24.
//

import XCTest

final class CleanHarborsiOSCTUITests: XCTestCase {
    
    func testEnterGridSizeAndCalculate() {
        let app = XCUIApplication()
        app.launch()
        
        // Access text field for grid size
        let gridSizeTextField = app.textFields.element
        XCTAssertTrue(gridSizeTextField.exists)
        
        gridSizeTextField.tap()
        app.keys["1"].tap()
        app.buttons["Calculate"].tap()
        
        // Access and verify the result texts
        let pathSuccessfulText = app.staticTexts["Path Successful: True"]
        XCTAssertTrue(pathSuccessfulText.exists)
        
        let pathCostText = app.staticTexts["Cost of shortest path: 0"]
        XCTAssertTrue(pathCostText.exists)
        
        let pathText = app.staticTexts["Path: 0"]
        XCTAssertTrue(pathText.exists)
        
    }
    
}
