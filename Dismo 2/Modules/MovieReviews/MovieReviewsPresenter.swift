//
//  MovieReviewsPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation

class MovieReviewsPresenter: MovieReviewsPresenterProtocol {
    weak var view: MovieReviewsViewProtocol?
    
    var interactor: MovieReviewsInputInteractorProtocol?
    
    var router: MovieReviewsRouterProtocol?
    
    func getReviews() {
        interactor?.fetchReviews()
    }
    
    
}

extension MovieReviewsPresenter: MovieReviewsOutputInteractorProtocol {
    func didGetAllData() {
        view?.hideLoadingView()
    }
    
    func didGetReview(_ reviews: [MovieReview], _ totalReviews: Int, _ indexPathToReload: [IndexPath]?) {
        view?.showReviews(reviews, totalReviews, indexPathToReload)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
    
}
