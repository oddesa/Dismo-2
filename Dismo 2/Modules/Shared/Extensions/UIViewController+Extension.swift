//
//  UIViewController+Extension.swift
//  Dismo 2
//
//  Created by Jehnsen Hirena Kane on 14/04/23.
//

import UIKit

extension UIViewController {
    func popupAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
