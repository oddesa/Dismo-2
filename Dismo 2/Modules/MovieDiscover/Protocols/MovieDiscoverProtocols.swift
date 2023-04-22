//
//  MovieDiscoverProtocols.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import UIKit
import Shared

public protocol MovieDiscoverPresenterProtocol: AnyObject {
    var view: MovieDiscoverViewProtocol? { get set }
    var interactor: MovieDiscoverInteractorInputProtocol? { get set }
    var router: MovieDiscoverRouterProtocol? { get set }
    var genredMovies: [GenredDiscoverMovies] { get set }
    var genres: [MovieGenre] { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func getMoviewDetail(movieId: Int)
    func getMoviesByGenre(genre: MovieGenre)
    func showMovieCollectionsScreen(genre: MovieGenre)
}

public protocol MovieDiscoverViewProtocol: AnyObject {
    var presenter: MovieDiscoverPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func reloadView()
    func showErrorMessage(_ message: String)
}

public protocol MovieDiscoverInteractorInputProtocol: AnyObject {
    var presenter: MovieDiscoverInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchGenre()
    func getMovieDetail(movieId: Int)
    func fetchMoviesByGenre(genre: MovieGenre)
}

public protocol MovieDiscoverInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didGetGenre(_ genres: [MovieGenre])
    func didGetMovieDetail(_ details: MovieDetails)
    func didFetchMoviesByGenre(_ movies: GenredDiscoverMovies)
    func onError(message: String)
}

public protocol MovieDiscoverRouterProtocol: AnyObject {
    static func createMovieDiscoverModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentMovieDetailsScreen(from view: MovieDiscoverViewProtocol, for movie: MovieDetails)
    func presentMovieCollectionsScreen(from view: MovieDiscoverViewProtocol, for genre: MovieGenre)
}
