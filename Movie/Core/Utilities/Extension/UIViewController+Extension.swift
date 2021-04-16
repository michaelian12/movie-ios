//
//  UIViewController+Extension.swift
//  Movie
//
//  Created by Michael Agustian on 16/04/21.
//

import UIKit

extension UIViewController {

    func showToast(message: String, duration seconds: Double = 2) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}
