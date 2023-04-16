//
//  MoviePaginationResponse.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation

struct MoviePaginatedResponse<T: Codable>: Codable {
    let page: Int?
    let results: [T]?
    let totalResults: Int?
    let totalPages: Int?
    
    enum Keys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.results = try container.decodeIfPresent([T].self, forKey: .results)
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
    }
}

