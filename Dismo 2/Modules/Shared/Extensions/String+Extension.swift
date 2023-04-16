//
//  String+Extension.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 16/04/23.
//

import UIKit

extension String {
    var html: NSMutableAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("Error \(error)")
            return nil
        }
    }
    
    func getHTMl(with font: UIFont) -> NSMutableAttributedString? {
        guard let html = html else {
            return nil
        }
        let range = NSRange(location: 0, length: html.length)
        html.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return html
    }
}
