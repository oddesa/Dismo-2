//
//  MovieDetails.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation

struct MovieDetails: Codable {
    let backdropPath: String?
    let genres: [MovieGenre]?
    let homepage: String?
    let id: Int?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Float?
    let voteCount: Int?
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    enum Keys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case homepage
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.genres = try container.decodeIfPresent([MovieGenre].self, forKey: .genres)
        self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.video = try container.decodeIfPresent(Bool.self, forKey: .video)
        self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
}
