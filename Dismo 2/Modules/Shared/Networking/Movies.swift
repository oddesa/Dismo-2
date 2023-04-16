//
//  Movies.swift
//  MandiriDummyProject
//
//  Created by Jehnsen Hirena Kane on 13/04/23.
//

import Foundation
import Moya

public enum Movies {
    static func getProvider() -> MoyaProvider<Movies> {
        return MoyaProvider<Movies>()
    }
    static private let apiKey = "5d33718a7f85a451830637377f4746d2"

    case movieGenreList
    case discoverMovies(genresId: [Int], page: Int)
    case movieReviews(movieId: Int, page: Int)
    case movieDetails(movieId: Int)
    case movieTrailers(moviedId: Int)
}

extension Movies: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    private var authParam: [String : Any] {
        ["api_key": Movies.apiKey]
    }
    
    
    public var path: String {
        switch self {
        case .discoverMovies(_, _):
            return "/discover/movie"
        case .movieGenreList:
            return "/genre/movie/list"
        case .movieReviews(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .movieDetails(let movieId):
            return "/movie/\(movieId)"
        case .movieTrailers(let moviedId):
            return "/movie/\(moviedId)/videos"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .movieReviews(_, let page):
            // TODO: Add page parameter
            return .requestParameters(parameters: ["page": page] + authParam,
                                      encoding: URLEncoding.default)
            
        case .discoverMovies(let genresId, let page):
            // TODO: Add page parameter
            let genresIdString = genresId.map{ $0.description }.joined(separator: ",")
            return .requestParameters(parameters: ["with_genres" : genresIdString,
                                                   "page": page] + authParam,
                                      encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: authParam,
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
