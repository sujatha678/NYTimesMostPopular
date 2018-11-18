//
//  APIManager.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import UIKit
import Alamofire

typealias CompletionHandler = (_ result: [Any]?, _ error: Error?) -> Void

private enum API {
    static let BASE_URL = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/"
    static let API_KEY = "d23d4fa0dad243289c132964beac0178"
}

enum ServiceType: String {
    case json = ".json?api-key="
    case xml = ".xml?api-key="
}

enum Period: Int {
    case one = 1
    case seven = 7
    case thirty = 30
}

struct Identifiers {
    static let articleDetail = "ArticleDetail"
}

class APIManager: NSObject {
    static let sharedInstance = APIManager()
    
    class func getNYTimesData(_ noOfDays: Period = .seven, serviceType: ServiceType = .json, completionHandler: @escaping CompletionHandler) {
      
        let urlString: String = String(format: "%@%d%@%@", API.BASE_URL, noOfDays.rawValue, serviceType.rawValue, API.API_KEY)
        
        guard let url = URL(string: urlString) else { return }
        let headerslogin = ["Content-Type": "application/json"]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headerslogin).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                //Decoder to parse the Articles
                let decoder = JSONDecoder()
                let articleResult = try decoder.decode(ArticlesData.self, from: data)
                completionHandler(articleResult.articles, nil)
            } catch let error {
                completionHandler(nil, error)
            }
           // completionHandler(response.result.value as? NSDictionary, response.result.error as NSError?)
            #if DEBUG
            #endif
        }
    }
}
