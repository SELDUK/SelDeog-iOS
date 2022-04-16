//
//  WriteComplimentViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/15.
//

import UIKit

import SnapKit

final class WriteComplimentViewController: UIViewController {
    
    let commentLabel = UILabel()
    let commentTextView = UITextView()
    let tagLabel = UILabel()
    let tag1ImageView = UIImageView()
    let tag1TextField = UITextField()
    let separateView1 = UIView()
    let tag2ImageView = UIImageView()
    let tag2TextField = UITextField()
    let separateView2 = UIView()
    let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font : UIFont.nanumPen(size: 15, family: .bold)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title = ""
    }
    
}

extension WriteComplimentViewController {
    
    private func setProperties() {
        
        view.backgroundColor = .white

        commentLabel.do {
            $0.text = "COMMENT"
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        commentTextView.do {
            $0.textColor = .black
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.isScrollEnabled = false
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        tagLabel.do {
            $0.text = "TAG"
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        tag1ImageView.do {
            $0.image = Image.hashTagIcon
        }
        
        tag1TextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "귀여워", attributes: attributes)
            $0.clearButtonMode = .never
            $0.keyboardType = .alphabet
            $0.layer.borderWidth = 0
            $0.autocapitalizationType = .none
        }
        
        separateView1.do {
            $0.backgroundColor = .black
        }
        
        tag2ImageView.do {
            $0.image = Image.hashTagIcon
        }
        
        tag2TextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "너무너무기특해", attributes: attributes)
            $0.clearButtonMode = .never
            $0.keyboardType = .alphabet
            $0.layer.borderWidth = 0
            $0.autocapitalizationType = .none
        }
        
        separateView2.do {
            $0.backgroundColor = .black
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(commentLabel, commentTextView, tagLabel, tag1ImageView, tag1TextField, separateView1, tag2ImageView, tag2TextField, separateView2)
    }
    
    private func setConstraints() {
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(108)
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.bottom).offset(68)
            $0.centerX.equalToSuperview()
        }
        
        tag1ImageView.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(19)
        }
        
        tag1TextField.snp.makeConstraints {
            $0.centerY.equalTo(tag1ImageView)
            $0.leading.equalTo(tag1ImageView.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
        }
        
        separateView1.snp.makeConstraints {
            $0.top.equalTo(tag1ImageView.snp.bottom).offset(6)
            $0.leading.equalTo(tag1ImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        tag2ImageView.snp.makeConstraints {
            $0.top.equalTo(separateView1.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(19)
        }
        
        tag2TextField.snp.makeConstraints {
            $0.centerY.equalTo(tag2ImageView)
            $0.leading.equalTo(tag1ImageView.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
        }
        
        separateView2.snp.makeConstraints {
            $0.top.equalTo(tag2ImageView.snp.bottom).offset(6)
            $0.leading.equalTo(tag2ImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
    }
    
}
