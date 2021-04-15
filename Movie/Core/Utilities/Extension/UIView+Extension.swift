//
//  UIView+Extension.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit

extension UIView {

    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()

        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
    
}
