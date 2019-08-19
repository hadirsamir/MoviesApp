//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by ASamir on 6/28/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MoviesAppTests: XCTestCase {
    let pageNo = 2
    var arrayCount: Int = 20
 
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//
    func testApiWithExpectation(){
        let apiURL = MoviesConstants.MOVIE_URL + "1"
        let url = apiURL
        let expect = expectation(description: "Get Data Succeded")
        if  url ==  apiURL {
            APIManager.httpRequest(urlRequest: url) { (movieObject, MovieArray) in
                XCTAssertNotNil(MovieArray, "No object Returned")
                
                expect.fulfill()
        }
      
      self.waitForExpectations(timeout: 10, handler: nil)
    }
       
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}
