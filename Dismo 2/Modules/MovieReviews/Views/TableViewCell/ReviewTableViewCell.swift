//
//  ReviewTableViewCell.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit
import Shared

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
        super.awakeFromNib()
        loadingView.hidesWhenStopped = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
        avatarImageView.clipsToBounds = true
        reviewLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        loadingView.startAnimating()
    }
    
    func setupContent(_ data: MovieReview) {
        loadingView.stopAnimating()
        nameLabel.text = data.author
        avatarImageView.setImageWithPlaceholder(url: data.authorDetails?.avatarURL, systemPlaceholder: "person.fill")
        ratingLabel.text = data.authorDetails?.username
        reviewLabel.attributedText = data.content.getHTMl(with: .systemFont(ofSize: 16))
    }
    
    func showLoadingView() {
        loadingView.startAnimating()
    }
}
