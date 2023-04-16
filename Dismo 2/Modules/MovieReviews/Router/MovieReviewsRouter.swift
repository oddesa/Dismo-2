//
//  MovieReviewsRouter.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import UIKit

class MovieReviewsRouter: MovieReviewsRouterProtocol {
    func navigateBackToDetailViewController(from view: MovieReviewsViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createMovieReviewsModule(with movieId: Int) -> UIViewController {
        let viewController: MovieReviewsViewProtocol & UIViewController = MovieReviewsTableViewController()
        let presenter: MovieReviewsPresenterProtocol & MovieReviewsOutputInteractorProtocol = MovieReviewsPresenter()
        let interactor: MovieReviewsInputInteractorProtocol = MovieReviewsInteractor()
        let router: MovieReviewsRouterProtocol = MovieReviewsRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.movieId = movieId
        
        interactor.presenter = presenter
        
        return viewController
    }
}
