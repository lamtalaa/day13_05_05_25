//
//  SearchResult.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/5/25.
//

import Foundation

struct SearchResponse: Decodable {
    let Results: [ResultItem]
    let RelatedTopics: [RelatedTopicItem]
}

struct ResultItem: Decodable {
    let FirstURL: String
    let Text: String
}

struct RelatedTopicItem: Decodable {
    let FirstURL: String
    let Text: String
}
