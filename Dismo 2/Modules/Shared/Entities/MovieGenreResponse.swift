//
//  MovieGenres.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation

struct MovieGenreResponse: Codable {
    let genres: [MovieGenre]
}

struct MovieGenre: Codable {
    let id: Int?
    let name: String?
}
