//
//  SetCharacterNameViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/23.
//

import UIKit

import SnapKit

final class SetCharacterNameViewController: BaseViewController {
    
    private let characterLabel = UILabel()
    private let loadingBar = UIProgressView()
    private let titleLabel = UILabel()
    private let shapeImageView = UIImageView()
    private let expressionImageView = UIImageView()
    private let featureImageView = UIImageView()
    private let startQuotationMarkLabel = UILabel()
    private let finishQuotationMarkLabel = UILabel()
    private let nameTextField = UITextField()
    private let nextButton = UIButton()
    private let popButton = UIButton()
    private let popBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
        setLoadingBarAnimation()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func setLoadingBarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingBar.setProgress(1.0, animated: true)
        }
    }
}

extension SetCharacterNameViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        popBarButton.do {
            $0.customView = popButton
            $0.customView?.translatesAutoresizingMaskIntoConstraints = false
            $0.customView?.heightAnchor.constraint(equalToConstant: 35).isActive = true
            $0.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        }
        
        navigationItem.do{
            $0.leftBarButtonItem = popBarButton
        }
        
        characterLabel.do {
            $0.text = "MY CHARACTER"
            $0.textColor = .black
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        loadingBar.do {
            $0.layer.cornerRadius = 8.5
            $0.clipsToBounds = true
            $0.layer.sublayers![1].cornerRadius = 8.5
            $0.subviews[1].clipsToBounds = true
            $0.progress = 3 / 4
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "4. NAME"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        startQuotationMarkLabel.do {
            $0.text = "''"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        finishQuotationMarkLabel.do {
            $0.text = "''"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        nameTextField.do {
            $0.delegate = self
            $0.textColor = .black
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.inputAccessoryView = nil
            $0.textAlignment = .center
            $0.font = .nanumPen(size: 30, family: .bold)
            $0.becomeFirstResponder()
        }
        
        shapeImageView.do {
            $0.image = CharacterData.selectedColorWithShape
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expressionWink
            $0.contentMode = .scaleToFill
        }
        
        featureImageView.do {
            $0.image = CharacterData.selectedFeature
            $0.contentMode = .scaleToFill
        }
        
        nextButton.do {
            $0.setTitle("OK", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 30, family: .bold)
        }
        
        popButton.do {
            $0.setImage(Image.arrowLeftIcon, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(characterLabel, loadingBar, titleLabel, shapeImageView, startQuotationMarkLabel, finishQuotationMarkLabel, nameTextField, nextButton)
        shapeImageView.addSubviews(expressionImageView, featureImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
        expressionImageView.bringSubviewToFront(featureImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        characterLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.centerX.equalToSuperview()
        }
        
        loadingBar.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        startQuotationMarkLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48)
            $0.trailing.equalTo(nameTextField.snp.leading).offset(-10)
        }
        
        nameTextField.snp.makeConstraints {
            $0.centerY.equalTo(startQuotationMarkLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        finishQuotationMarkLabel.snp.makeConstraints {
            $0.centerY.equalTo(startQuotationMarkLabel)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(290)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(290)
        }
        
        featureImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(290)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(80)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case nextButton:
            if let name = nameTextField.text {
                if name.trimmingCharacters(in: .whitespaces).count == 0 {
                       showToastMessageAlert(message: "닉네임을 입력해주세요")
                    nameTextField.text = name.trimmingCharacters(in: .whitespaces)
                } else {
                    CharacterData.nickname = name.trimmingCharacters(in: .whitespaces)
                    let confirmCharacterViewController = ConfirmCharacterViewController()
                    navigationController?.pushViewController(confirmCharacterViewController, animated: true)
                }
            }
        case popButton:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }

}

extension SetCharacterNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
         
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
         
            return updatedText.count <= 10
        }
}
