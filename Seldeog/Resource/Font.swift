//
//  Font.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/16.
//

import UIKit.UIFont

extension UIFont {

    enum Family: String {
        case bold, regular
    }

    static func nanumPen(size: CGFloat, family: Family) -> UIFont {
        switch family {
        case .bold:
            guard let font = UIFont(name: "NanumBarunpenOTF-Bold", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        case .regular:
            guard let font = UIFont(name: "NanumBarunpenOTF", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}
