//
//  India2016Tests.swift
//  India2016Tests
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import XCTest
@testable import India2016

class India2016Tests: XCTestCase {
    
    var parseData : ParseData!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
         parseData = ParseData()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testAllContentLoaded(){
        
        // given
        let expectation  = self.expectation(description: "expected commments count to be 15 ")

        
        //when
        // content count during build is 15
        parseData.authenticate {
            
            XCTAssertEqual(self.parseData.array.count,15, "parse data was not 15")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)

    }
    
        // then
        
    
 
    
    func testCommentsLoaded(){
        
        // use image id 838
        
        
        parseData.fetchComments(imageID: "838") {
            XCTAssertGreaterThan(self.parseData.array.count,0, "comments count doesnt contain any objects")

        }
    }
    

    
    func testMainCollectionHasExpectedValues() {
        
        parseData.authenticate {
           
            self.verifyMainCollectionHasExpectedValues(index: 0)

        }
    }
    
    func verifyMainCollectionHasExpectedValues(index : Int) {
        
        let collection  = self.parseData.array
        
        XCTAssertEqual(collection[index].username, "rawane", "Rawane isnt the username for this object")
        XCTAssertEqual(collection[index].numberOfComments, "0", "number of comments dosnt equal 0")
        XCTAssertEqual(collection[index].numberOfLikes, "1", "number of likes dosnt equal 1 for this object expected 1")
    }
    
}
