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
    
    // TODO: Mock this test so it doesn't actually hit the url everytime  
    func testGetImageFromURL_onCompletionShouldReturnTrue() {
        let testHolidayImage = HolidayImageFromURL()
        let expect = expectation(description: "Pulls image from url and returns success: true")
        
        testHolidayImage.makeGetRequest(imageId: "10030", imageType: "10") { success, image in
            XCTAssertTrue(success)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
