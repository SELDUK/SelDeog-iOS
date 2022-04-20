//
//  AboutMeCell.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/20.
//

import UIKit
import SnapKit
import Then

final class AboutMeCell: UITableViewCell {
    
    let cellView = UIView()
    let cellIndexLabel = UILabel()
    let featureLabel = UILabel()
    let lineView = UIView()
    let dateLabel = UILabel()
    let modifyButton = UIButton()
    let deleteButton = UIButton()
    var commentIndex: Int?
    var cellIndex: Int?
    var buttonDelegate: CommentButtonProtocol?

    public func setCellIndex(index: Int) {
        cellIndexLabel.text = "0\(index)"
        cellIndex = index
    }
    
    public func setCompliment(text: String) {
        featureLabel.text = text
    }
    
    public func setCommentIndex(index: Int) {
        commentIndex = index
    }
    
    public func setDate(text: String) {
        dateLabel.text = text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setProperties()
        setLayouts()
        registerTarget()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerTarget() {
        [modifyButton, deleteButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }

    private func setProperties() {
        cellView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
        }
        
        cellIndexLabel.do {
            $0.font = .nanumPen(size: 20, family: .bold)
        }
        
        featureLabel.do {
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.numberOfLines = 0
            $0.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        lineView.do {
            $0.backgroundColor = .black
        }
        
        dateLabel.do {
            $0.font = .nanumPen(size: 11, family: .bold)
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
        contentView.addSubviews(cellView)
        cellView.addSubviews(cellIndexLabel, featureLabel, lineView, dateLabel, modifyButton, deleteButton)
    }

    private func setConstraints() {
        cellView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        cellIndexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(12)
            $0.width.equalTo(21)
        }
        
        featureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(cellIndexLabel.snp.trailing).offset(13)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(featureLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.height.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(13)
            $0.bottom.equalToSuperview().offset(-14)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-13)
            $0.width.equalTo(16)
            $0.height.equalTo(19)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-9)
            $0.width.height.equalTo(18)
            $0.bottom.equalToSuperview().offset(-9)
        }
    }
    
    @objc
    private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case modifyButton:
            if let commentIndex = commentIndex, let cellIndex = cellIndex {
                self.buttonDelegate?.modifyComment(serverIndex: commentIndex, cellIndex: cellIndex)
            }
        case deleteButton:
            if let index = commentIndex {
                self.buttonDelegate?.deleteComment(index: index)
            }
        default:
            return
        }
    }
}
