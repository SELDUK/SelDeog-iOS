//
//  WriteComplimentViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/15.
//

import UIKit

import SnapKit

final class WriteComplimentViewController: BaseViewController {
    
    private let commentLabel = UILabel()
    private let commentTextView = UITextView()
    private let wordCountLabel = UILabel()
    private let tagLabel = UILabel()
    private let tag1ImageView = UIImageView()
    private let tag1TextField = UITextField()
    private let tag1WordCountLabel = UILabel()
    private let separateView1 = UIView()
    private let tag2ImageView = UIImageView()
    private let tag2TextField = UITextField()
    private let tag2WordCountLabel = UILabel()
    private let separateView2 = UIView()
    private let registerButton = UIButton()
    private let popButton = UIButton()
    private let attributes = [
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
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    private func postComment(comment: String, tag: [String]) {
        if let index = CharacterData.characterIndex {
            postComment(usrChrIdx: index, comment: comment, tag: tag) { data in
                if data.success {
                    self.navigationController?.popViewController(animated: false)
                } else {
                    self.showToastMessageAlert(message: "코멘트 작성에 실패하였습니다.")
                }
            }
        }
    }
    
    private func postComment(
        usrChrIdx: Int,
        comment: String,
        tag: [String],
        completion: @escaping (UserResponse) -> Void
    ) {
        UserRepository.shared.postComment(usrChrIdx: usrChrIdx, comment: comment, tag: tag) { result in
            switch result {
            case .success(let response):
                print(response)
                guard let data = response as? UserResponse else { return }
                completion(data)
            default:
                print("sign in error")
            }
        }
    }
    
}

extension WriteComplimentViewController {
    
    private func setProperties() {
        
        view.backgroundColor = .white
        
        navigationItem.do {
            $0.setLeftBarButtonItems([UIBarButtonItem(customView: popButton)], animated: false)
        }

        commentLabel.do {
            $0.text = "COMMENT"
            $0.textColor = .black
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        commentTextView.do {
            $0.delegate = self
            $0.text = "칭찬을 작성해주세요"
            $0.backgroundColor = .white
            $0.textColor = UIColor.lightGray
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.isScrollEnabled = false
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        wordCountLabel.do {
            $0.textColor = .black
            $0.text = "0/50자"
            $0.font = .nanumPen(size: 11, family: .bold)
        }
        
        tagLabel.do {
            $0.text = "TAG"
            $0.textColor = .black
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        tag1ImageView.do {
            $0.image = Image.hashTagIcon
        }
        
        tag1TextField.do {
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "귀여워", attributes: attributes)
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.textColor = .black
            $0.clearButtonMode = .never
            $0.layer.borderWidth = 0
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        tag1WordCountLabel.do {
            $0.textColor = .black
            $0.text = "0/10자"
            $0.font = .nanumPen(size: 11, family: .bold)
        }
        
        separateView1.do {
            $0.backgroundColor = .black
        }
        
        tag2ImageView.do {
            $0.image = Image.hashTagIcon
        }
        
        tag2TextField.do {
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "너무너무기특해", attributes: attributes)
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.textColor = .black
            $0.clearButtonMode = .never
            $0.layer.borderWidth = 0
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        tag2WordCountLabel.do {
            $0.textColor = .black
            $0.text = "0/10자"
            $0.font = .nanumPen(size: 11, family: .bold)
        }
        
        separateView2.do {
            $0.backgroundColor = .black
        }
        
        registerButton.do {
            $0.backgroundColor = .black
            $0.setTitle("OK", for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 30, family: .bold)
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
        
        popButton.do {
            $0.setImage(Image.arrowLeftIcon, for: .normal)
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(commentLabel, commentTextView, wordCountLabel, tagLabel, tag1ImageView, tag1TextField, separateView1, tag2ImageView, tag2TextField, separateView2, registerButton)
        tag1TextField.addSubview(tag1WordCountLabel)
        tag2TextField.addSubview(tag2WordCountLabel)
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
        
        wordCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(commentTextView.snp.trailing).offset(-11)
            $0.bottom.equalTo(commentTextView.snp.bottom).offset(-11)
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.bottom).offset(48)
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
        
        tag1WordCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
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
            $0.leading.equalTo(tag2ImageView.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
        }
        
        tag2WordCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        separateView2.snp.makeConstraints {
            $0.top.equalTo(tag2ImageView.snp.bottom).offset(6)
            $0.leading.equalTo(tag2ImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case tag1TextField:
            tag1WordCountLabel.text = "\(tag1TextField.text?.count ?? 0)/10자"
        case tag2TextField:
            tag2WordCountLabel.text = "\(tag2TextField.text?.count ?? 0)/10자"
        default:
            return
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case registerButton:
            var tag: [String] = []
            
            var commentTrimText = ""
            
            if (commentTextView.textColor == UIColor.lightGray) || commentTextView.text.count == 0 {
                self.showToastMessageAlert(message: "칭찬을 작성해주세요")
                return
            } else {
                commentTrimText = commentTextView.text.trimmingCharacters(in: .whitespaces)
            }
            
            if let tag1 = tag1TextField.text {
                if !tag1.isEmpty {
                    tag.append(tag1.trimmingCharacters(in: .whitespaces))
                }
            }
            
            if let tag2 = tag2TextField.text {
                if !tag2.isEmpty {
                    tag.append(tag2.trimmingCharacters(in: .whitespaces))
                }
            }
            
            postComment(comment: commentTrimText, tag: tag)
        case popButton:
            self.setAlertConfirmAndCancel(message: "해당 페이지를 벗어나면 작성 중인 내용이 저장되지 않습니다. 정말 나가시겠습니까?")
        default:
            return
        }
    }
}

extension WriteComplimentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      if commentTextView.textColor == UIColor.lightGray {
          commentTextView.text = nil
          commentTextView.textColor = UIColor.black
      }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      if commentTextView.text.isEmpty {
        commentTextView.text = "칭찬을 작성해주세요"
        commentTextView.textColor = UIColor.lightGray
      }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text != "\n" else { return false }
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        wordCountLabel.text = "\(changedText.count)/50자"
        return changedText.count <= 49
    }
}

extension WriteComplimentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
         
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
         
            return updatedText.count <= 10
        }
}
