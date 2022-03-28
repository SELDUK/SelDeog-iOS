//
//  CheckButton.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//


import UIKit

class CheckButton : UIButton {

    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.tintColor = UIColor.black
            }
            else{
                self.tintColor = UIColor.colorWithRGBHex(hex: 0xF4F3F3)
            }
        }
    }
}
