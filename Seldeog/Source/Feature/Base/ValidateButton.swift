//
//  ValidateButton.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/30.
//

import UIKit

final class ValidateButton: UIButton {
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.setImage(Image.validPassword, for: .normal)
            }
            else{
                self.setImage(Image.invalidPassword, for: .normal)
            }
        }
    }
}
