//
//  MovieCollectionViewCell.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = UIImage(systemName: "film.fill")
    }
    
    func setupContent(_ url: URL?) {
        movieImageView.setImageWithPlaceholder(url: url, systemPlaceholder: "film.fill")
    }
}
