//
//  MovieReviewsPresenter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation
import Shared

class MovieReviewsPresenter: MovieReviewsPresenterProtocol {
    weak var view: MovieReviewsViewProtocol?
    var interactor: MovieReviewsInputInteractorProtocol?
    var router: MovieReviewsRouterProtocol?
    
    var reviews = [MovieReview]()
    var page = 1
    var movieId: Int?
    var alreadyGetAllData = false
    var totalReviews = 0
    
    func getReviews() {
        guard let movieId = movieId,
        alreadyGetAllData == false else {
            return
        }
        interactor?.fetchReviews(movieId, page)
    }
}

extension MovieReviewsPresenter: MovieReviewsOutputInteractorProtocol {
    func didGetAllData() {
        alreadyGetAllData = true
        view?.hideLoadingView()
    }
    
    func didGetReview(_ reviews: [MovieReview], _ totalReviews: Int, _ page: Int) {
        self.reviews.append(contentsOf: reviews)
        self.totalReviews = totalReviews + 1
        self.page = page
        let indexPathToReload = page == 2 ? nil : calculateIndexPathsToReload(from: reviews)
        view?.showReviews(reviews, totalReviews, indexPathToReload)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
    private func calculateIndexPathsToReload(from newData: [MovieReview]) -> [IndexPath] {
        let startIndex = reviews.count - newData.count
        let endIndex = startIndex + newData.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
