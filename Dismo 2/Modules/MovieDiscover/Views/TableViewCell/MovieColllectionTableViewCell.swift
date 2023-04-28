//
//  MovieColllectionTableViewCell.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class MovieColllectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    var movies = [DiscoverMovie]()
    var genre: MovieGenre?
    
    var onTapMovie: ((_ movie: DiscoverMovie) -> Void)?
    var onTapChevron: ((_ genre: MovieGenre) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        setupCollectionView()
        chevronButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movies = []
        collectionView.reloadData()
    }
    
    @IBAction func chevronTapped(_ sender: Any) {
        guard let genre = self.genre else {
            return
        }
        onTapChevron?(genre)
    }
    
    private func setupCollectionView() {
        collectionViewFlowLayout.itemSize = .init(width: 110, height: 160)
        collectionViewFlowLayout.minimumInteritemSpacing = 2
        collectionViewFlowLayout.scrollDirection = .horizontal
//        collectionView.register(nibWithCellClass: MovieCollectionViewCell.self)
//        let bundle = Bundle(for: Self.self)
//        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: bundle)
//        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: MovieCollectionViewCell.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupContent(_ data: GenredDiscoverMovies) {
        genreLabel.text = data.genre.name
        movies = data.movies
        genre = data.genre
    }
}

extension MovieColllectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MovieCollectionViewCell.self, for: indexPath)
        // will trigger error if movie doesnt have any valid poster url
        cell.setupContent(movies[indexPath.row].posterURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapMovie?(movies[indexPath.row])
    }
}
