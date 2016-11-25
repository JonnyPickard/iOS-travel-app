//
//  HolidayImageTests.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import XCTest
@testable import TravelRepublic

class HolidayImageTests: XCTestCase {
    
    func testGetImageId() {
        let testHolidayImage: HolidayImage = HolidayImage()
        let mockString = "10|10030"
        
        let result = testHolidayImage.getImageId(imageString: mockString)
        let expectedResult = "10030"
        
        XCTAssertTrue((result == expectedResult), "#getImageID successfully parses input string and returns id")
    }
    
    func testGetImageType() {
        let testHolidayImage: HolidayImage = HolidayImage()
        let mockString = "10|10030"
        
        let result = testHolidayImage.getImageType(imageString: mockString)
        let expectedResult = "10"
        
        XCTAssertTrue((result == expectedResult), "#getImageType successfully parses input string and returns type")
    }
    
}
