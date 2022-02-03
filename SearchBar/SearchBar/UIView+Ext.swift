//
//  UIView+Ext.swift
//  SearchBar
//
//  Created by haanwave on 2022/02/03.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor? = nil, width: CGFloat, radius: CGFloat? = nil, masks: Bool = true) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        if let radius = radius {
            layer.cornerRadius = radius
            layer.masksToBounds = masks
        }
    }
}
