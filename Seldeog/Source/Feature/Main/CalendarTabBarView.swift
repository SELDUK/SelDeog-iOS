//
//  CalendarTabBarView.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class CalendarTabBarView: UIView {
    
    let tabBarView = UIView()
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
        tabBarView.do {
            $0.backgroundColor = UIColor(patternImage: Image.tabBarBG)
        }
        
        calendarButton.do {
            $0.setImage(Image.calendarIcon, for: .normal)
            $0.setTitle("CALENDAR", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        selfLoveButton.do {
            $0.setImage(Image.loveIcon, for: .normal)
            $0.setTitle("SELF-LOVE", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        aboutMeButton.do {
            $0.setImage(Image.aboutMeIcon, for: .normal)
            $0.setTitle("ABOUT ME", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
        
        settingButton.do {
            $0.setImage(Image.settingIcon, for: .normal)
            $0.setTitle("SETTING", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 10, family: .bold)
            $0.alignTextBelow()
        }
    }
    
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy() {
        addSubview(tabBarView)
        tabBarView.addSubviews(calendarButton, selfLoveButton, aboutMeButton, settingButton)
    }
    
    func setConstraints() {
        tabBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        calendarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(44)
            $0.height.equalTo(38)
        }
        
        selfLoveButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarButton)
            $0.leading.equalTo(calendarButton.snp.trailing).offset(25)
            $0.width.equalTo(47)
            $0.height.equalTo(38)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-23)
            $0.width.height.equalTo(38)
        }
        
        aboutMeButton.snp.makeConstraints {
            $0.centerY.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-31)
            $0.width.equalTo(44)
            $0.height.equalTo(38)
        }
        
    }
    
}
