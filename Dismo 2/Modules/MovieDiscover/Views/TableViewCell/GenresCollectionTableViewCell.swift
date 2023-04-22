//
//  GenresCollectionTableViewCell.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class GenresCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var genres = [MovieGenre]()
    var onTapGenre: ((_ genre: MovieGenre) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        collectionViewFlowLayout.itemSize = .init(width: 80, height: 80)
        collectionView.register(nibWithCellClass: GenreCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadCollectionView(_ data: [MovieGenre]) {
        genres = data
        collectionView.reloadData()
    }
}

extension GenresCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GenreCollectionViewCell.self, for: indexPath)
        let genre = genres[indexPath.row]
        cell.setupContent(genre)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapGenre?(genres[indexPath.row])
    }
}
