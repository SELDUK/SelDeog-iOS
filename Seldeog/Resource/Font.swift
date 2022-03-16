//
//  Font.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/16.
//

import UIKit.UIFont

extension UIFont {

    enum Family: String {
        case B, R
    }

    static func nanumPen(size: CGFloat, family: Family) -> UIFont {
        guard let font = UIFont(name: "NanumBarunpen\(family)", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
