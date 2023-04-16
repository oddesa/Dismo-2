//
//  MovieDetailsPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInputInteractorProtocol?
    var router: MovieDetailsRouterProtocol?
    
    func getTrailer() {
        interactor?.fetchTrailer()
    }
    
    func showMovieReviews() {
        interactor?.getMovieId()
    }
}

extension MovieDetailsPresenter: MovieDetailsOutputInteractorProtocol {
    func didGetMovieId(_ id: Int) {
        guard let view = view else {
            return
        }
        router?.navigateToReviewsScreen(from: view, for: id)
    }
    
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
