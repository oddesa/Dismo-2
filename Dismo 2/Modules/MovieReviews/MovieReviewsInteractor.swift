//
//  MovieReviewsInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation

class MovieReviewsInteractor: MovieReviewsInputInteractorProtocol {
    weak var presenter: MovieReviewsOutputInteractorProtocol?
    var movieId: Int?
    var page = 1
    var alreadyGetAllData = false
    let provider = Movies.getProvider()
    var reviews = [MovieReview]()
    
    func fetchReviews() {
        guard let movieId = movieId,
              alreadyGetAllData == false
        else {
            return
        }
        provider.request(.movieReviews(movieId: movieId, page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let mappedResponse = try response.map(MoviePaginatedResponse<MovieReview>.self)
                    self?.page += 1
                    guard let reviews = mappedResponse.results, !reviews.isEmpty else {
                        self?.alreadyGetAllData = true
                        // Handle edge case where movie doesnt have review yet
                        if self?.page == 2 {
                            self?.presenter?.onError(message: "No reviews yet. Watch the movie and become the first reviewer!")
                        } else {
                            self?.presenter?.didGetAllData()
                        }
                        return
                    }
                    self?.reviews.append(contentsOf: reviews)
                    let indexPathToReload = self?.page == 2 ? nil : self?.calculateIndexPathsToReload(from: reviews)
                    self?.presenter?.didGetReview(reviews,
                                                  mappedResponse.totalResults ?? 0,
                                                  indexPathToReload)
                } catch {
                    self?.presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                self?.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newData: [MovieReview]) -> [IndexPath] {
        let startIndex = reviews.count - newData.count
        let endIndex = startIndex + newData.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
