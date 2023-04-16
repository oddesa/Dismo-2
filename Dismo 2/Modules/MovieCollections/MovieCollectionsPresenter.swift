//
//  MovieCollectionsPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation

class MovieCollectionsPresenter: MovieCollectionsPresenterProtocol {
    weak var view: MovieCollectionsViewProtocol?
    
    var interactor: MovieCollectionsInteractorInputProtocol?
    
    var router: MovieCollectionsRouterProtocol?
    
    func getMoviewDetail(movieId: Int) {
        interactor?.fetchMovieDetail(movieId: movieId)
    }
    
    func getMovies() {
        interactor?.fetchMovies()
    }
    
    
}

extension MovieCollectionsPresenter: MovieCollectionsInteractorOutputProtocol {
    func didGetMovies(_ movies: [DiscoverMovie], _ totalMovies: Int, _ indexPathToReload: [IndexPath]?) {
        view?.showMovies(movies, totalMovies, indexPathToReload)
    }

    func didGetMovieDetail(_ details: MovieDetails) {
        guard let view = view else {
            return
        }
        router?.presentMovieDetailsScreen(from: view, for: details)
    }
    
    func didGetAllData() {
        view?.hideLoadingView()
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
}
