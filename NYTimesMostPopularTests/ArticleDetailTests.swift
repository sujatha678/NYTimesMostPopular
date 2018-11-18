//
//  ArticleDetailTests.swift
//  NYTimesMostPopularTests
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import XCTest
@testable import NYTimesMostPopular

class ArticleDetailTests: XCTestCase {
    
    var controllerUnderTest: ArticleDetailViewController!
    
    override func setUp() {
        super.setUp()
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as? ArticleDetailViewController {
            controllerUnderTest = viewController
            _ = controllerUnderTest.view
        }
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        super.tearDown()
    }
    
    func testWebviewLoading() {
        
        guard let urlPath = Bundle.main.url(forResource: "MockResponse", withExtension: "json"), let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let articleResult = try decoder.decode(ArticlesData.self, from: jsonData)
            controllerUnderTest.article = articleResult.articles.first
            controllerUnderTest.loadArticleDetails()
        } catch  {
            XCTAssertNotNil("Data cannot be nil to see list")
        }
    }
    
    
}
