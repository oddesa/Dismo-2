//
//  MovieTrailerResponse.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation

struct MovieTrailerResponse: Codable {
    let id: Int
    let results: [MovieTrailerDetail]
    var officialTrailerKey:  String? {
        return results.first{$0.official}?.key ?? results.first?.key
    }
}

struct MovieTrailerDetail: Codable {
    let id: String
    let key: String
    let official: Bool
}

