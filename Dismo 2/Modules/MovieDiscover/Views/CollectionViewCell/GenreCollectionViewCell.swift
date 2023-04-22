//
//  GenreCollectionViewCell.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genreImageView.contentMode = .scaleAspectFit
        genreLabel.numberOfLines = 2
        genreLabel.adjustsFontSizeToFitWidth = true
    }

    func setupContent(_ data: MovieGenre) {
        genreLabel.text = data.name
        let imageName:String
        switch data.name?.lowercased() {
        case "action":
            imageName = "hammer.circle"
        case "adventure":
            imageName = "airplane.circle"
        case "animation":
            imageName = "person.2.wave.2"
        case "comedy":
            imageName = "mouth"
        case "crime":
            imageName = "fork.knife.circle"
        case "documentary":
            imageName = "pawprint"
        case "drama":
            imageName = "person.2.circle"
        case "fantasy":
            imageName = "allergens"
        case "family":
            imageName = "person.3.sequence"
        case "history":
            imageName = "book.closed.circle"
        case "horor":
            imageName = "eye"
        case "music":
            imageName = "music.mic.circle"
        case "mystery":
            imageName = "magnifyingglass.circle"
        case "romance":
            imageName = "heart.circle"
        case "science fiction":
            imageName = "bolt.shield.fill"
        case "tv movie":
            imageName = "tv.circle"
        case "thriller":
            imageName = "eye.circle.fill"
        case "war":
            imageName = "flag.filled.and.flag.crossed"
        case "western":
            imageName = "burn"
        default:
            imageName = "books.vertical.fill"
        }
        genreImageView.image = UIImage(systemName: imageName)
    }
}
