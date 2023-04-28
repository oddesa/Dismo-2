//
//  MovieDetailsInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation
import Shared

class MovieDetailsInteractor: MovieDetailsInputInteractorProtocol {
    weak var presenter: MovieDetailsOutputInteractorProtocol?
    var provider = Movies.getProvider()
    
    func fetchTrailer(movieId: Int) {
        provider.request(.movieTrailers(moviedId: movieId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let youtubeKey = try response.map(MovieTrailerResponse.self).officialTrailerKey
                    self.presenter?.didGetTrailer(youtubeKey ?? "")
                } catch {
                    self.presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                self.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
}
