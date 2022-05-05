//
//  ComplimentWithTwoTagCell.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import UIKit
import SnapKit
import Then
import CloudKit

final class ComplimentWithTwoTagCell: UICollectionViewCell {
    
    let cellIndexLabel = UILabel()
    let complimentLabel = UILabel()
    let lineView = UIView()
    let tag1View = HashTagView()
    let tag2View = HashTagView()
    let modifyButton = UIButton()
    let deleteButton = UIButton()
    var commentIndex: Int?
    var cellIndex: Int?
    var buttonDelegate: CommentButtonProtocol?

    public func setCellIndex(index: Int) {
        cellIndexLabel.text = "0\(index)"
        cellIndex = index
    }
    
    public func setCommentIndex(index: Int) {
        commentIndex = index
    }
    
    public func setCompliment(text: String) {
        complimentLabel.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.do {
            $0.backgroundColor = .white
        }
        
        cellIndexLabel.do {
            $0.textColor = .black
            $0.font = .nanumPen(size: 20, family: .bold)
        }
        
        complimentLabel.do {
            $0.textColor = .black
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
        contentView.addSubviews(cellIndexLabel, complimentLabel, lineView, tag1View, tag2View, modifyButton, deleteButton)
    }

    private func setConstraints() {
        cellIndexLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        complimentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(cellIndexLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(complimentLabel.snp.bottom).offset(8)
            $0.leading.equalTo(complimentLabel)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(1)
        }
        
        tag1View.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.leading.equalTo(complimentLabel)
        }
        
        tag2View.snp.makeConstraints {
            $0.centerY.equalTo(tag1View)
            $0.leading.equalTo(tag1View.snp.trailing).offset(5)
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
