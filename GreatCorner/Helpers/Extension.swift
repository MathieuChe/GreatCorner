//
//  Extension.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

extension UIView {
    func setupCornerRadius() {
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
}
