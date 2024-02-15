//
//  CleanHarborsiOSCTTests.swift
//  CleanHarborsiOSCTTests
//
//  Created by Puja Gogineni on 2/15/24.
//

import XCTest
@testable import CleanHarborsiOSCT

final class CleanHarborsiOSCTTests: XCTestCase {

    func testCalculateMinimumCostPath() {
        let viewModel = GridViewModel()
        
        viewModel.gridSizeString = "3"
        viewModel.grid.rows = [["1", "2", "3"],
                               ["4", "5", "6"],
                               ["7", "8", "9"]]
        
        viewModel.calculateMinimumCostPath()
        
        // Check path is successful
        XCTAssertTrue(viewModel.pathSuccessful == "True")
        
        // check Pathcost is correct
        XCTAssertEqual(viewModel.pathCost, "12")
        
        // check path is correct
        XCTAssertEqual(viewModel.path, "1,2,3,4,5,6,9")
        
    }

}
