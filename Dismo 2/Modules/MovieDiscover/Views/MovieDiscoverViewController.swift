//
//  MovieDiscoverViewController.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class MovieDiscoverViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var presenter: MovieDiscoverPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidesWhenStopped = true
        title = "Dismo"
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
        if let genredMoviesAmount = presenter?.genredMovies.count {
            return section == 0 ? 1 : genredMoviesAmount
        } else {
            return section == 0 ? 1 : 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: GenresCollectionTableViewCell.self)
            cell.onTapGenre = presentMovieCollectionsScreen
            if let genres = presenter?.genres {
                cell.reloadCollectionView(genres)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: MovieColllectionTableViewCell.self)
            guard let genredMovies = presenter?.genredMovies else {
                return cell
            }
            cell.setupContent(genredMovies[indexPath.row])
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
    func reloadView() {
        mainTableView.reloadData()
    }
    
    func showErrorMessage(_ message: String) {
        popupAlert(title: "Error", message: message)
    }
}
