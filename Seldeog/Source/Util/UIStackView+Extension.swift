//
//  UIStackView+Extension.swift
//  Seldeog
//
//  Created by 권준상 on 2022/05/05.
//

import UIKit.UIStackView

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
