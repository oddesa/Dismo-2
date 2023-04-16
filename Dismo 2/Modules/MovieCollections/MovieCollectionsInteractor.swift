//
//  MovieCollectionsInteractor.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import Foundation

class MovieCollectionInteractor: MovieCollectionsInteractorInputProtocol {
    var page = 1
    weak var presenter: MovieCollectionsInteractorOutputProtocol?
    let provider = Movies.getProvider()
    var genre: MovieGenre?
    var movies = [DiscoverMovie]()
    var alreadyGetAllData = false
    
    func fetchMovieDetail(movieId: Int) {
        provider.request(.movieDetails(movieId: movieId)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do {
                    self.presenter?.didGetMovieDetail(try response.map(MovieDetails.self))
                } catch {
                    self.presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func fetchMovies() {
        guard let genreId = genre?.id else {
            return
        }
        provider.request(.discoverMovies(genresId: [genreId], page: page)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let mappedResponse = try response.map(MoviePaginatedResponse<DiscoverMovie>.self)
                    self.page += 1
                    guard let movies = mappedResponse.results, !movies.isEmpty else {
                        self.alreadyGetAllData = true
                        self.presenter?.didGetAllData()
                        return
                    }
                    self.movies.append(contentsOf: movies)
                    let indexPathToReload = self.page == 2 ? nil : self.calculateIndexPathsToReload(from: movies)
                    self.presenter?.didGetMovies(movies,
                                                 mappedResponse.totalResults ?? 0,
                                                 indexPathToReload)
                } catch {
                    presenter?.onError(message: error.localizedDescription)
                }
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newData: [DiscoverMovie]) -> [IndexPath] {
        let startIndex = movies.count - newData.count
        let endIndex = startIndex + newData.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
