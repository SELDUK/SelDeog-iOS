//
//  SettingTextCell.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/06.
//

import SnapKit
import UIKit

class SettingTextCell: UITableViewCell {

    private let settingIconImageView = UIImageView()
    
    private let cellTitleLabel = UILabel().then {
        $0.font = UIFont.nanumPen(size: 20, family: .bold)
        $0.textColor = .black
    }

    private let cellTextLabel = UILabel().then {
        $0.font = UIFont.nanumPen(size: 15, family: .bold)
        $0.text = "1.0.0"
        $0.textColor = .black
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setViewHierarchy()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setImage(image: UIImage) {
        settingIconImageView.contentMode = .scaleAspectFit
        settingIconImageView.image = image
    }
    
    public func setTitle(title: String) {
        cellTitleLabel.text = title
    }

    private func setViewHierarchy() {
        contentView.addSubviews(settingIconImageView, cellTitleLabel, cellTextLabel)
    }

    private func setConstraints() {
        settingIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(20)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(settingIconImageView.snp.trailing).offset(12)
        }

        cellTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}
