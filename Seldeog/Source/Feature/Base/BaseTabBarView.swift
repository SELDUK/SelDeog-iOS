//
//  BaseTabBarView.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import UIKit

import SnapKit
import Then

final class BaseTabBarView: UIView {
    
    let tabBarView = UIView()
    let stackView = UIStackView()
    let calendarButton = ExpandButton()
    let selfLoveButton = ExpandButton()
    let aboutMeButton = ExpandButton()
    let settingButton = ExpandButton()
    
    public init() {
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProperties() {
        stackView.do {
            $0.backgroundColor = .black
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing

            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 25,
                                     left: 30,
                                     bottom: 20,
                                     right: 30)
        }
        
        calendarButton.do {
            $0.setImage(Image.calendarIcon, for: .normal)
            $0.setTitle("CALENDAR", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x707070), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        selfLoveButton.do {
            $0.setImage(Image.loveIcon, for: .normal)
            $0.setTitle("SELF-LOVE", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x707070), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        aboutMeButton.do {
            $0.setImage(Image.aboutMeIcon, for: .normal)
            $0.setTitle("ABOUT ME", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x707070), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        settingButton.do {
            $0.setImage(Image.settingIcon, for: .normal)
            $0.setTitle("SETTING", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x707070), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(calendarButton, selfLoveButton, aboutMeButton, settingButton)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
