//
//  UIImageView + Extension.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import UIKit

extension UIImageView {
    static func configureImageView(cornerRadius: CGFloat, contentMode:  UIView.ContentMode, backgroundColor: UIColor?) -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = cornerRadius
        imageView.contentMode = contentMode
        imageView.backgroundColor = backgroundColor
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
