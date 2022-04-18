//
//  SelectColorView.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/18.
//

import UIKit

final class SelectColorView: UIView {
    
    let backgroundView = UIView()
    let titleLabel = UILabel()
    let colorStackView = UIStackView()
    let navyColor = UIButton()
    let yellowColor = UIButton()
    let pinkColor = UIButton()
    let mauveColor = UIButton()
    let greenColor = UIButton()

    public init() {
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }

    private func setViewHierarchy() {
        self.addSubview(backgroundView)
        backgroundView.addSubviews(titleLabel, colorStackView)
        [navyColor, yellowColor, pinkColor, mauveColor, greenColor].forEach {
            colorStackView.addArrangedSubview($0)
        }
    }

    private func setConstraints() {
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }
        
        colorStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        [navyColor, yellowColor, pinkColor, mauveColor, greenColor].forEach {
            $0.snp.makeConstraints { $0.width.height.equalTo(38) }
        }
    }

    private func setProperties() {
        backgroundView.do {
            $0.backgroundColor = UIColor(patternImage: Image.selectColorViewBG)
        }
        
        titleLabel.do {
            $0.text = "TODAY'S COLOR"
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.textColor = .black
        }
        
        colorStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
            $0.distribution = .fillProportionally
        }
                
        navyColor.do {
            $0.setImage(Image.colorNavy, for: .normal)
            $0.tag = 1
        }
        
        yellowColor.do {
            $0.setImage(Image.colorYellow, for: .normal)
            $0.tag = 2
        }
        
        pinkColor.do {
            $0.setImage(Image.colorPink, for: .normal)
            $0.tag = 3
        }
        
        mauveColor.do {
            $0.setImage(Image.colorMauve, for: .normal)
            $0.tag = 4
        }
        
        greenColor.do {
            $0.setImage(Image.colorGreen, for: .normal)
            $0.tag = 5
        }
        
        self.alpha = 0.0
    }
}
