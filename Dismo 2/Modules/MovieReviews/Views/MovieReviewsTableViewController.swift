//
//  MovieReviewsTableViewController.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared
class MovieReviewsTableViewController: UITableViewController {
    
    var presenter: MovieReviewsPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.getReviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupTableView() {
        tableView.register(nibWithCellClass: ReviewTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.prefetchDataSource = self
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let totalReviews = presenter?.totalReviews else {
            return 0
        }
        return totalReviews
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ReviewTableViewCell.self)
        if isLoadingCell(for: indexPath) {
            cell.showLoadingView()
        } else {
            if let reviews = presenter?.reviews {
                cell.setupContent(reviews[indexPath.row])
            }
        }
        return cell
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let reviews = presenter?.reviews else {
            return false
        }
        return indexPath.row >= reviews.count
    }
    
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension MovieReviewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter?.getReviews()
        }
    }
}

extension MovieReviewsTableViewController: MovieReviewsViewProtocol {
    func hideLoadingView() {
        guard let totalReviews = presenter?.totalReviews else {
            return
        }
        presenter?.totalReviews = totalReviews > 0 ? totalReviews - 1 : 0
        tableView.reloadData()
    }
    
    func showReviews(_ reviews: [MovieReview], _ totalReviews: Int, _ indexPathToReload: [IndexPath]?) {
        if let indexPathToReload = indexPathToReload {
            let newIndexPathToReload = visibleIndexPathsToReload(intersecting: indexPathToReload)
            tableView.reloadRows(at: newIndexPathToReload, with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
    
    func showErrorMessage(_ message: String) {
        popupAlert(title: "Error", message: message)
    }
}
