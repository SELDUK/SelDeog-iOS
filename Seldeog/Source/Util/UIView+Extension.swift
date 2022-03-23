//
//  UIView+Extension.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
