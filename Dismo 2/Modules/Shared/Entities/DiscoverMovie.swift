//
//  DiscoverMovie.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation


struct GenredDiscoverMovies {
    let genre: MovieGenre
    let movies: [DiscoverMovie]
}

struct DiscoverMovie: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let id: Int?
    let title: String?
    let backdropPath: String?
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    enum Keys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case title
        case backdropPath = "backdrop_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) 
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) 
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) 
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) 
        self.genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
    }
}
