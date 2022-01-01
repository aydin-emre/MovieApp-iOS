//
//  UIViewExtension.swift
//  MovieApp
//
//  Created by Emre on 1.01.2022.
//

import UIKit

extension UIView {

    func addBorder(color: UIColor = .gray, radius: CGFloat = 0, borderWidth: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = radius
    }

    func round(radius: CGFloat = 8, masksToBounds: Bool = false) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = masksToBounds
    }

    func rounded(masksToBounds: Bool = false) {
        round(radius: self.frame.size.width/2, masksToBounds: masksToBounds)
    }

    func addShadow(radius: CGFloat = 8) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = radius
    }

}
