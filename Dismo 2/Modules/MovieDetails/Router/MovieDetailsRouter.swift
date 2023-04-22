//
//  MovieDetailsRouter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import UIKit
import Shared

class MovieDetailsRouter: MovieDetailsRouterProtocol {
    func presentTrailerScreen(from view: MovieDetailsViewProtocol, for key: String) {
        let youtubeVC = YoutubePlayerViewController(videoId: key)
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.present(youtubeVC, animated: true)
    }
    
    func navigateToReviewsScreen(from view: MovieDetailsViewProtocol, for movieId: Int) {
//        let reviewsVC = MovieReviewsRouter.createMovieReviewsModule(with: movieId)
//        guard let viewVC = view as? UIViewController else {
//            fatalError("Invalid view protocol type")
//        }
//        viewVC.navigationController?.pushViewController(reviewsVC, animated: true)
        Router.route?(.reviewsPage(movieId: movieId))
    }
    
    func navigateBackToDiscoverViewController(from view: MovieDetailsViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createMovieDetailsModule(with details: MovieDetails) -> UIViewController {
        let viewController: MovieDetailsViewProtocol & UIViewController = MovieDetailsViewController(movieDetails: details)
        let presenter: MovieDetailsPresenterProtocol & MovieDetailsOutputInteractorProtocol = MovieDetailsPresenter()
        let interactor: MovieDetailsInputInteractorProtocol = MovieDetailsInteractor()
        let router: MovieDetailsRouterProtocol = MovieDetailsRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.movieDetails = details
        interactor.presenter = presenter
        
        return viewController
    }
}
