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
    let loadingBar = UIImageView()
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
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
}

extension SetCharacterNameViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = UIColor(patternImage: Image.checkPattern)
        }
        
        navigationController?.do {
            $0.navigationBar.setBackgroundImage(Image.checkPattern, for: .default)
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.isTranslucent = true
        }
        
        navigationItem.do {
            $0.leftBarButtonItem = UIBarButtonItem(customView: popButton)
        }
        
        myCharacterLabel.do {
            $0.text = "MY CHARACTER"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        loadingBar.do {
            $0.image = Image.progressBar2
        }
        
        titleLabel.do {
            $0.text = "3. NAME"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 25, family: .bold)
        }
        
        startQuotationMarkLabel.do {
            $0.text = "''"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 25, family: .bold)
        }
        
        finishQuotationMarkLabel.do {
            $0.text = "''"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 25, family: .bold)
        }
        
        nameTextField.do {
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.inputAccessoryView = nil
            $0.textAlignment = .center
            $0.font = .nanumPen(size: 20, family: .bold)
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
            $0.titleLabel?.font = .nanumPen(size: 25, family: .bold)
        }
        
        popButton.do {
            $0.setImage(Image.arrowLeft, for: .normal)
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
            $0.top.equalTo(myCharacterLabel.snp.bottom).offset(26)
            $0.leading.equalTo(safeArea).offset(54)
            $0.width.equalTo(222)
            $0.height.equalTo(29)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
        
        startQuotationMarkLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.trailing.equalTo(nameTextField.snp.leading).offset(-10)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(startQuotationMarkLabel.snp.top).offset(-5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(36)
        }
        
        finishQuotationMarkLabel.snp.makeConstraints {
            $0.centerY.equalTo(startQuotationMarkLabel)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        featureImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(250)
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
