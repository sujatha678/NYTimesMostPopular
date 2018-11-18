//
//  APIManagerTests.swift
//  NYTimesMostPopularTests
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import XCTest
import Alamofire

@testable import NYTimesMostPopular

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfullGetArticleFromNYTimes() {
        
        APIManager.getNYTimesData(.seven) { (result, error) in
            guard error == nil else { return }
            XCTAssertNotNil(result, "Got Articles list from NYTimes")
        }
    }
    
    func testFailableGetArticleFromNYTimes() {
        APIManager.getNYTimesData(.thirty) { (result, error) in
            guard error != nil else { return }
            XCTAssertNil(result, "Failed getting Articles list from NYTimes")
        }
    }
    
    func testSuccessfullServiceCall() {
        // given
        let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=3f34a872362e4df29f242a5f7b8d5924")
        // 1
        let promise = expectation(description: "Status code: 200")
        let headerslogin = ["Content-Type": "application/json"]
        
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default, headers: headerslogin).responseJSON {  response in
            // then
            if let error = response.error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = response.response?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFailableServiceCall() {
        // given
        let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=3f34a872362e4df29f242a5f7b8d59242")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        let headerslogin = ["Content-Type": "application/json"]
        var statusCode: Int?
        var responseError: Error?
        
        // when
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default, headers: headerslogin).responseJSON { response in
            statusCode = response.response?.statusCode
            responseError = response.error
            // 2
            promise.fulfill()
        }
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 403)
    }
    
}
