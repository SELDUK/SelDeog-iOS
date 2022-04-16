//
//  HashTagView.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import UIKit
import SnapKit
import Then

final class HashTagView: UIView {
        
    public var text: String? = nil {
        didSet {
            self.textLabel.text = self.text
            self.setViewSize()
        }
    }
    
    private let hashTagImageView = UIImageView().then {
        $0.image = Image.hashTagIcon
    }
    
    private let textLabel = UILabel().then {
        $0.font = .nanumPen(size: 12, family: .bold)
    }

    public init() {
        super.init(frame: .zero)
        setViewSize()
        setBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewSize() {
        self.addSubview(hashTagImageView)
        self.addSubview(textLabel)
        
        self.snp.updateConstraints {
            $0.height.equalTo(18)
        }
        
        hashTagImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(6)
            $0.width.height.equalTo(10)
        }
        
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(hashTagImageView.snp.trailing).offset(3)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    private func setBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 9
    }
    
}
