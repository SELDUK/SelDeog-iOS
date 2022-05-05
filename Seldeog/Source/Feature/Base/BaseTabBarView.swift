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
    let calendarButton = UIButton()
    let selfLoveButton = UIButton()
    let aboutMeButton = UIButton()
    let settingButton = UIButton()
    
    public init() {
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties() {
        stackView.do {
            $0.backgroundColor = .black
            $0.axis = .horizontal
            $0.spacing = 45
            $0.alignment = .fill

            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = .init(top: 0,
                                     left: 40,
                                     bottom: 0,
                                     right: 40)
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
    
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(calendarButton, selfLoveButton, aboutMeButton, settingButton)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        calendarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(41)
            $0.width.equalTo(44)
            $0.height.equalTo(38)
        }
        
        selfLoveButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarButton)
            $0.leading.equalTo(calendarButton.snp.trailing).offset(44)
            $0.width.equalTo(47)
            $0.height.equalTo(38)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-45)
            $0.width.height.equalTo(38)
        }
        
        aboutMeButton.snp.makeConstraints {
            $0.centerY.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-46)
            $0.width.equalTo(44)
            $0.height.equalTo(38)
        }
        
    }
    
}
