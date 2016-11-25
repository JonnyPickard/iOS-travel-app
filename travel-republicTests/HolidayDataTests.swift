//
//  HolidayDataTests.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import XCTest
@testable import TravelRepublic

class HolidayDataTests: XCTestCase {
 
    func testGetImageId() {
        let testHolidayData: HolidayData = HolidayData()
        let mockString = "10|10030"
        
        let result = testHolidayData.getImageId(imageString: mockString)
        let expectedResult = "10030"
        
        XCTAssertTrue((result == expectedResult), "#getImageID successfully parses input string and returns id")
    }
    
    func testGetImageType() {
        let testHolidayData: HolidayData = HolidayData()
        let mockString = "10|10030"
        
        let result = testHolidayData.getImageType(imageString: mockString)
        let expectedResult = "10"
        
        XCTAssertTrue((result == expectedResult), "#getImageType successfully parses input string and returns type")
    }
}
