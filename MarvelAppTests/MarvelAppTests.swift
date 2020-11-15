//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import XCTest
@testable import MarvelApp

class MarvelAppTests: XCTestCase {

    func testConnectionManager() {
        let data = ConnectionManager()
           
        let result = data
        XCTAssertNotNil(result)
        
    }

    
}
