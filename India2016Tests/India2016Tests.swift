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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testAllContentLoaded(){
        
        // content count during build is 15
        let parseData = ParseData()
        parseData.authenticate {
            XCTAssertEqual(parseData.array.count,15, "parse data was not 15")
        }
    }
    
    func testCommentsLoaded(){
        
        // use image id 838
        
        let parseData = ParseData()
        
        parseData.fetchComments(imageID: "838") {
            XCTAssertGreaterThan(parseData.array.count,0, "comments count doesnt contain any objects")

        }
    }
    

    
    func testConnectionToServer(){
        
    }
    
    func testSendComment(){
        
    }
    
}
