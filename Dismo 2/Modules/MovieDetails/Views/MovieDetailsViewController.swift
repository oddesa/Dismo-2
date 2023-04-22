//
//  MovieDetailsViewController.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var subInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    var presenter: MovieDetailsPresenterProtocol?
    
    init(movieDetails: MovieDetails) {
        super.init(nibName: "MovieDetailsViewController",
                   bundle: nil)
        setupContent(movieDetails)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func playTraillerTapped(_ sender: Any) {
        presenter?.getTrailer()
    }
    
    @IBAction func reviewTapped(_ sender: Any) {
        presenter?.showMovieReviews()
    }
    
    private func setupContent(_ movieDetails: MovieDetails) {
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.layer.cornerRadius = 20
            self?.backdropImageView.setImageWithPlaceholder(url: movieDetails.backdropURL,
                                                            systemPlaceholder: "film.fill")
            self?.posterImageView.setImageWithPlaceholder(url: movieDetails.posterURL,
                                                          systemPlaceholder: "film.fill")
            self?.titleLabel.text = movieDetails.title
            self?.subInfoLabel.text = "Released on \(movieDetails.releaseDate ?? "")"
            self?.directorLabel.text = "Genre: " + (movieDetails.genres?.first?.name ?? "Movie")
            self?.durationLabel.text = "\(movieDetails.runtime ?? 90) Minutes"
            self?.descriptionLabel.text = movieDetails.overview
        }
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func showErrorMessage(_ message: String) {
        popupAlert(title: "Error", message: message)
    }
}
