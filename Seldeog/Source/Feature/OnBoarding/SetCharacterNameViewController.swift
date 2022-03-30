//
//  SetCharacterNameViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/23.
//

import UIKit

import SnapKit

final class SetCharacterNameViewController: BaseViewController {
    
    let myCharacterLabel = UILabel()
    let loadingBar = UIProgressView()
    let titleLabel = UILabel()
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let featureImageView = UIImageView()
    let startQuotationMarkLabel = UILabel()
    let finishQuotationMarkLabel = UILabel()
    let nameTextField = UITextField()
    let nextButton = UIButton()
    let popButton = UIButton()
    
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
        
        navigationController?.do {
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.isTranslucent = true
        }
        
        navigationItem.do {
            $0.leftBarButtonItem = UIBarButtonItem(customView: popButton)
        }
        
        myCharacterLabel.do {
            $0.text = "MY CHARACTER"
            $0.textColor = UIColor.black
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
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.inputAccessoryView = nil
            $0.textAlignment = .center
            $0.font = .nanumPen(size: 30, family: .bold)
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        shapeImageView.do {
            $0.image = CharacterData.selectedShape
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expressionSmile
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
            $0.setImage(Image.popButton, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(myCharacterLabel, loadingBar, titleLabel, shapeImageView, startQuotationMarkLabel, finishQuotationMarkLabel, nameTextField, nextButton)
        shapeImageView.addSubviews(expressionImageView, featureImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
        expressionImageView.bringSubviewToFront(featureImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        myCharacterLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        loadingBar.snp.makeConstraints {
            $0.top.equalTo(myCharacterLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        startQuotationMarkLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(68)
            $0.trailing.equalTo(nameTextField.snp.leading).offset(-10)
        }
        
        nameTextField.snp.makeConstraints {
            $0.centerY.equalTo(startQuotationMarkLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        finishQuotationMarkLabel.snp.makeConstraints {
            $0.centerY.equalTo(startQuotationMarkLabel)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
        }
        
        featureImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
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
            CharacterData.nickname = nameTextField.text
            let confirmCharacterViewController = ConfirmCharacterViewController()
            navigationController?.pushViewController(confirmCharacterViewController, animated: true)
        case popButton:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
    
    @objc func textFieldDidChange() {
        
    }
}
