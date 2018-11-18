//
//  ArticleData.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import Foundation
struct ArticlesData: Decodable {
    //Holds the list of articles
    var articles: [ArticleData]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    
    init(from decoder: Decoder) throws {
        
        //Container will map based on the CodingKeys
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //To Get Array response for the given key - "results"
        var resultsArray = try values.nestedUnkeyedContainer(forKey: .results)
        
        var articles = [ArticleData]()
        //Till the last article finished loop and append to array
        while(!resultsArray.isAtEnd) {
            articles.append(try resultsArray.decode(ArticleData.self))
        }
        self.articles = articles
    }
}

struct ArticleData: Decodable {
    var title: String?
    var abstract: String?
    var byLine: String?
    var publishedDate: String?
    var section: String?
    var urlString: String?
    var mediaImages: [ImageData]?
    var mediaIhmages: [ImageData]?
    enum CodingKeys: String, CodingKey {
        case title, abstract, section
        case byLine = "byline"
        case publishedDate = "published_date"
        case urlString = "url"
        case mediaImages = "media"
    }
    
    init(from decoder: Decoder) throws {
        //Container will map based on the CodingKeys
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try values.decode(String.self, forKey: .title)
        self.abstract = try values.decode(String.self, forKey: .abstract)
        self.byLine = try values.decode(String.self, forKey: .byLine)
        self.publishedDate = try values.decode(String.self, forKey: .publishedDate)
        self.section = try values.decode(String.self, forKey: .section)
        self.urlString = try values.decode(String.self, forKey: .urlString)
        
        //To Get Array response for the given key - "results"
        var mediaArray = try values.nestedUnkeyedContainer(forKey: .mediaImages)
        
        var images = [ImageData]()
        while(!mediaArray.isAtEnd) {
            images.append(try mediaArray.decode(ImageData.self))
        }
        self.mediaImages = images
    }
}

struct ImageData: Decodable {
    
    var imagesDetails: [ImageDetails]?
    
    private enum CodingKeys: String, CodingKey {
        case imageDetails = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        //Container will map based on the CodingKeys
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //To Get Array response for the given key - "results"
        var metaDataArray = try values.nestedUnkeyedContainer(forKey: .imageDetails)
        
        var imagesDetails = [ImageDetails]()
        while(!metaDataArray.isAtEnd) {
            imagesDetails.append(try metaDataArray.decode(ImageDetails.self))
        }
        self.imagesDetails = imagesDetails
    }
}

struct ImageDetails: Decodable {
    var url: String?
    var format: String?
}
