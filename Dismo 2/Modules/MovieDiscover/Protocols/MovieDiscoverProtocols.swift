//
//  MovieDiscoverProtocols.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import UIKit

protocol MovieDiscoverPresenterProtocol: AnyObject {
    var view: MovieDiscoverViewProtocol? { get set }
    var interactor: MovieDiscoverInteractorInputProtocol? { get set }
    var router: MovieDiscoverRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func getMoviewDetail(movieId: Int)
    func getMoviesByGenre(genre: MovieGenre)
    func showMovieCollectionsScreen(genre: MovieGenre)
}

protocol MovieDiscoverViewProtocol: AnyObject {
    var presenter: MovieDiscoverPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showGenres(_ data: [MovieGenre])
    func showMovieRecommendations(_ data: [GenredDiscoverMovies])
    func showErrorMessage(_ message: String)
}

protocol MovieDiscoverInteractorInputProtocol: AnyObject {
    var presenter: MovieDiscoverInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchGenre()
    func getMovieDetail(movieId: Int)
    func fetchMoviesByGenre(genre: MovieGenre)
}

protocol MovieDiscoverInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didGetGenre(_ genres: [MovieGenre])
    func didGetMovieDetail(_ details: MovieDetails)
    func didFetchMoviesByGenre(_ movies: [GenredDiscoverMovies])
    func onError(message: String)
}

protocol MovieDiscoverRouterProtocol: AnyObject {
    static func createMovieDiscoverModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentMovieDetailsScreen(from view: MovieDiscoverViewProtocol, for movie: MovieDetails)
    func presentMovieCollectionsScreen(from view: MovieDiscoverViewProtocol, for genre: MovieGenre)
}
