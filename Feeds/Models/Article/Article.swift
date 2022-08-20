//
//  Article.swift
//  Feeds
//
//  Created by Tabish on 7/19/22.
//

import Foundation

struct Article: Codable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init(json: [String: Any]) {
        title = json["title"] as? String
        author = json["author"] as? String
        description = json["description"] as? String
        url = json["url"] as? String
        urlToImage = json["urlToImage"] as? String
    }
    
}
