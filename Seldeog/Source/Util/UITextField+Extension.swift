//
//  UITextField+Extension.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}
