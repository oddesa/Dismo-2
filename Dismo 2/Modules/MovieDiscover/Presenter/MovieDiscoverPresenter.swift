//
//  MovieDiscoverPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation
import Shared

class MovieDiscoverPresenter: MovieDiscoverPresenterProtocol {
    var view: MovieDiscoverViewProtocol?
    var interactor: MovieDiscoverInteractorInputProtocol?
    var router: MovieDiscoverRouterProtocol?
    var genredMovies = [GenredDiscoverMovies]()
    var genres = [MovieGenre]() {
        didSet {
            for genre in genres {
                getMoviesByGenre(genre: genre)
            }
        }
    }
    
    func viewDidLoad() {
        interactor?.fetchGenre()
    }
    
    func getMoviesByGenre(genre: MovieGenre) {
        interactor?.fetchMoviesByGenre(genre: genre)
    }
    
    func getMoviewDetail(movieId: Int) {
        interactor?.getMovieDetail(movieId: movieId)
    }
    
    func showMovieCollectionsScreen(genre: MovieGenre) {
        guard let view = view else {
            return
        }
        router?.presentMovieCollectionsScreen(from: view, for: genre)
    }
}

extension MovieDiscoverPresenter: MovieDiscoverInteractorOutputProtocol {
    func didGetGenre(_ genres: [MovieGenre]) {
        self.genres = genres
        view?.reloadView()
    }
    
    func didGetMovieDetail(_ details: MovieDetails) {
        guard let view = view else { return }
        router?.presentMovieDetailsScreen(from: view, for: details)
    }
    
    func didFetchMoviesByGenre(_ movies: GenredDiscoverMovies) {
        genredMovies.append(movies)
        view?.reloadView()
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
