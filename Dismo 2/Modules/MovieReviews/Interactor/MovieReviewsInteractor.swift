//
//  MovieReviewsInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation
import Shared

class MovieReviewsInteractor: MovieReviewsInputInteractorProtocol {
    weak var presenter: MovieReviewsOutputInteractorProtocol?
    let provider = Movies.getProvider()
    
    
    func fetchReviews(_ movieId: Int, _ page: Int) {
        provider.request(.movieReviews(movieId: movieId, page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let mappedResponse = try response.map(MoviePaginatedResponse<MovieReview>.self)
                    let newPage = page + 1
                    guard let reviews = mappedResponse.results, !reviews.isEmpty else {
                        // Handle edge case where movie doesnt have review yet
                        if newPage == 2 {
                            self?.presenter?.onError(message: "No reviews yet. Watch the movie and become the first reviewer!")
                        } else {
                            self?.presenter?.didGetAllData()
                        }
                        return
                    }
                    self?.presenter?.didGetReview(reviews,
                                                  mappedResponse.totalResults ?? 0,
                                                  newPage)
                } catch {
                    self?.presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                self?.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
}
