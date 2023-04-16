//
//  MovieDiscoverInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//

import Foundation

// TODO: Implement caching for movie detail using dict

class MovieDiscoverInteractor: MovieDiscoverInteractorInputProtocol {
    var presenter: MovieDiscoverInteractorOutputProtocol?
    let provider = Movies.getProvider()
//    var genres = [MovieGenre]()
    var genredMovies = [GenredDiscoverMovies]()
    
    func fetchGenre() {
        provider.request(.movieGenreList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    presenter?.didGetGenre(try response.map(MovieGenreResponse.self).genres)
                } catch {
                    presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func getMovieDetail(movieId: Int) {
        provider.request(.movieDetails(movieId: movieId)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do {
//                    let mappedResponse = try response.map(MovieDetails.self)
                    self.presenter?.didGetMovieDetail(try response.map(MovieDetails.self))
                } catch {
                    self.presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchMoviesByGenre(genre: MovieGenre) {
        guard let genreId = genre.id else {
            return
        }
        provider.request(.discoverMovies(genresId: [genreId], page: 1)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let movies = try response.map(MoviePaginatedResponse<DiscoverMovie>.self).results
                    genredMovies.append(GenredDiscoverMovies(genre: genre, movies: movies ?? []))
                    presenter?.didFetchMoviesByGenre(genredMovies)
                } catch {
                    presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
}