//
//  MovieDetailsPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation
import Shared

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInputInteractorProtocol?
    var router: MovieDetailsRouterProtocol?
    
    var trailerResponse: MovieTrailerResponse?
    var movieDetails: MovieDetails?
    
    func getTrailer() {
        guard let movieId = movieDetails?.id else {
            onError(message: "Please try again later")
            return
        }
        interactor?.fetchTrailer(movieId: movieId)
    }
    
    func showMovieReviews() {
        guard let view = view,
              let movieId = movieDetails?.id else {
            return
        }
        router?.navigateToReviewsScreen(from: view, for: movieId)
    }
}

extension MovieDetailsPresenter: MovieDetailsOutputInteractorProtocol {
    func didGetTrailer(_ key: String) {
        guard let view = view else {
            return
        }
        router?.presentTrailerScreen(from: view, for: key)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
