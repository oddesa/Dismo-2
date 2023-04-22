//
//  MovieReviewsProtocol.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import UIKit
import Shared

protocol MovieReviewsRouterProtocol: AnyObject {
    static func createMovieReviewsModule(with movieId: Int) -> UIViewController
    func navigateBackToDetailViewController(from view: MovieReviewsViewProtocol)
}

protocol MovieReviewsViewProtocol: AnyObject {
    var presenter: MovieReviewsPresenterProtocol? { get set }
    
    func showErrorMessage(_ message: String)
    func showReviews(_ reviews: [MovieReview], _ totalReviews: Int, _ indexPathToReload: [IndexPath]?)
    func hideLoadingView()
}

protocol MovieReviewsPresenterProtocol: AnyObject {
    var view: MovieReviewsViewProtocol? { get set }
    var interactor: MovieReviewsInputInteractorProtocol? { get set }
    var router: MovieReviewsRouterProtocol? { get set }
    
    var reviews: [MovieReview] { get set }
    var page: Int { get set }
    var movieId: Int? { get set }
    var alreadyGetAllData: Bool { get set }
    var totalReviews: Int { get set }
    
    func getReviews()
}

protocol MovieReviewsInputInteractorProtocol: AnyObject {
    var presenter: MovieReviewsOutputInteractorProtocol? { get set }
    
    func fetchReviews(_ movieId: Int, _ page: Int)
}

protocol MovieReviewsOutputInteractorProtocol: AnyObject {
    func didGetReview(_ reviews: [MovieReview], _ totalReviews: Int, _ page: Int)
    func didGetAllData()
    func onError(message: String)
}

