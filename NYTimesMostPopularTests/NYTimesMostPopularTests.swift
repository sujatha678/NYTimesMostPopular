//
//  NYTimesMostPopularTests.swift
//  NYTimesMostPopularTests
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import XCTest
@testable import NYTimesMostPopular

class NYTimesMostPopularTests: XCTestCase {
    var controllerUnderTest: ViewController!

    override func setUp() {
        super.setUp()
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            controllerUnderTest = viewController
            _ = controllerUnderTest.view
            controllerUnderTest.getArticlesData()
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        controllerUnderTest = nil

    }
    func testSuccessfullyLoadJSONFile() {
        
        guard let urlPath = Bundle.main.url(forResource: "MockResponse", withExtension: "json"), let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let articleResult = try decoder.decode(ArticlesData.self, from: jsonData)
            
            XCTAssertEqual(articleResult.articles.first?.section, "Technology", "Mathcing the Local JSON data")
            
            XCTAssertNotEqual(articleResult.articles.first?.publishedDate, "2018-06-06.", "Not Mathcing the Local JSON data")
            
            XCTAssertNotNil(articleResult, "Data cannot be nil to see list")
            
            controllerUnderTest.articles = articleResult.articles
            controllerUnderTest.articlesTableView?.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
            controllerUnderTest.articlesTableView?.dataSource = self as? UITableViewDataSource
            controllerUnderTest.articlesTableView?.delegate = (self as? UITableViewDelegate)
            
            controllerUnderTest.tableView(controllerUnderTest.articlesTableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        } catch  {
            XCTAssertNotNil("Data cannot be nil to see list")
        }
    }
    
    func testUnsuccessfullyLoadJSONFile() {
        
        guard let _ = Bundle.main.url(forResource: "MockResponse", withExtension: "json") else {
            XCTAssertNotNil("JSON file is missing")
            return
        }
        
        XCTAssertNotNil("Data is as per the flow")
    }
    
    
}
