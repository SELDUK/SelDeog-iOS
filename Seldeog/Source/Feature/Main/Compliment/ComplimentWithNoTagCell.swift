//
//  ComplimentWithNoTagCell.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import UIKit
import SnapKit
import Then

final class ComplimentWithNoTagCell: UICollectionViewCell {
    
    let indexLabel = UILabel()
    let complimentLabel = UILabel()
    let lineView = UIView()
    let modifyButton = UIButton()
    let deleteButton = UIButton()

    public func setIndex(index: Int) {
        indexLabel.text = "0\(index)"
    }
    
    public func setCompliment(text: String) {
        complimentLabel.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setProperties() {
        indexLabel.do {
            $0.font = .nanumPen(size: 20, family: .bold)
        }
        
        complimentLabel.do {
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.numberOfLines = 0
            $0.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        lineView.do {
            $0.backgroundColor = .black
        }
        
        modifyButton.do {
            $0.setImage(Image.modifyIcon, for: .normal)
        }
        
        deleteButton.do {
            $0.setImage(Image.deleteIcon, for: .normal)
        }
    }

    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }

    private func setViewHierarchy() {
        contentView.addSubviews(indexLabel, complimentLabel, lineView, modifyButton, deleteButton)
    }

    private func setConstraints() {
        indexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        complimentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(indexLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(complimentLabel.snp.bottom).offset(8)
            $0.leading.equalTo(complimentLabel)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(1)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.equalTo(16)
            $0.height.equalTo(19)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-9)
            $0.width.height.equalTo(18)
        }
    }
}
