//
//  MovieDetailsInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation

class MovieDetailsInteractor: MovieDetailsInputInteractorProtocol {
    var movieDetails: MovieDetails?
    weak var presenter: MovieDetailsOutputInteractorProtocol?
    var provider = Movies.getProvider()
    var trailerResponse: MovieTrailerResponse?
    
    func fetchTrailer() {
        guard trailerResponse == nil else {
            presenter?.didGetTrailer(trailerResponse?.officialTrailerKey ?? "")
            return
        }
        
        guard let movieId = movieDetails?.id else {
            presenter?.onError(message: "Please try again later")
            return
        }
        provider.request(.movieTrailers(moviedId: movieId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    trailerResponse = try response.map(MovieTrailerResponse.self)
                    presenter?.didGetTrailer(trailerResponse?.officialTrailerKey ?? "")
                } catch {
                    presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func getMovieId() {
        guard let movieId = movieDetails?.id else {
            presenter?.onError(message: "Please try again later")
            return
        }
        presenter?.didGetMovieId(movieId)
    }
}
