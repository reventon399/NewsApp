//
//  UILabel + Extension.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import UIKit

extension UILabel {
    static func configureLabel(fontSize: CGFloat,
                               fontWeight: UIFont.Weight,
                               textAlignment: NSTextAlignment,
                               textColor: UIColor?) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
}
