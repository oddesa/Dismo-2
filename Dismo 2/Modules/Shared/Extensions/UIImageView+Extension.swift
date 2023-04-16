//
//  UIImageView+Extension.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 15/04/23.
//
import Kingfisher

extension UIImageView {
    func setImageWithPlaceholder(url: URL?, systemPlaceholder: String) {
        let placeholderImage = UIImage(systemName: systemPlaceholder)
        guard let url = url else {
            image = placeholderImage
            return
        }
        self.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
