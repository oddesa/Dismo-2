//
//  MovieDetailsProtocol.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import UIKit
import Shared

protocol MovieDetailsRouterProtocol: AnyObject {
    static func createMovieDetailsModule(with details: MovieDetails) -> UIViewController
    func navigateBackToDiscoverViewController(from view: MovieDetailsViewProtocol)
    func presentTrailerScreen(from view: MovieDetailsViewProtocol , for key: String)
    func navigateToReviewsScreen(from view: MovieDetailsViewProtocol , for movieId: Int)
}

protocol MovieDetailsViewProtocol: AnyObject {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    
    func showErrorMessage(_ message: String) 
}

protocol MovieDetailsPresenterProtocol: AnyObject {
    var view: MovieDetailsViewProtocol? { get set }
    var interactor: MovieDetailsInputInteractorProtocol? { get set }
    var router: MovieDetailsRouterProtocol? { get set }
    
    var trailerResponse: MovieTrailerResponse? { get set }
    var movieDetails: MovieDetails? { get set }
    
    func getTrailer()
    func showMovieReviews()
}

protocol MovieDetailsInputInteractorProtocol: AnyObject {
    var presenter: MovieDetailsOutputInteractorProtocol? { get set }
    func fetchTrailer(movieId: Int)
}

protocol MovieDetailsOutputInteractorProtocol: AnyObject {
    func didGetTrailer(_ key: String)
    func onError(message: String)
}

