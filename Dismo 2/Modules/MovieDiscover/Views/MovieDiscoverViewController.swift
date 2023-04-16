//
//  MovieDiscoverViewController.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit

class MovieDiscoverViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var genres = [MovieGenre]() {
        didSet {
            for genre in genres {
                presenter?.getMoviesByGenre(genre: genre)
            }
        }
    }
    let provider = Movies.getProvider()
    var movies = [GenredDiscoverMovies]()
    var presenter: MovieDiscoverPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.hidesWhenStopped = true
        
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        loadingView.stopAnimating()
    }
    
    private func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(nibWithCellClass: GenresCollectionTableViewCell.self)
        mainTableView.register(nibWithCellClass: MovieColllectionTableViewCell.self)
        mainTableView.separatorStyle = .none
        mainTableView.showsVerticalScrollIndicator = false
    }
}

extension MovieDiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: GenresCollectionTableViewCell.self)
            cell.onTapGenre = presentMovieCollectionsScreen
            cell.reloadCollectionView(genres)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: MovieColllectionTableViewCell.self)
            cell.setupContent(movies[indexPath.row])
            cell.onTapMovie = { [weak self] movie in
                guard let movieId = movie.id else {
                    return
                }
                self?.loadingView.startAnimating()
                self?.presenter?.getMoviewDetail(movieId: movieId)
            }
            cell.onTapChevron = presentMovieCollectionsScreen
            return cell
        }
    }
    
    func presentMovieCollectionsScreen( _ genre: MovieGenre) {
        loadingView.startAnimating()
        presenter?.showMovieCollectionsScreen(genre: genre)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 70 : 200
    }
}

extension MovieDiscoverViewController: MovieDiscoverViewProtocol {
    func showGenres(_ data: [MovieGenre]) {
        self.genres = data
        mainTableView.reloadData()
    }
    
    func showMovieRecommendations(_ data: [GenredDiscoverMovies]) {
        self.movies = data
        mainTableView.reloadData()
    }
    
    func showErrorMessage(_ message: String) {
        popupAlert(title: "Error", message: message)
    }
}
