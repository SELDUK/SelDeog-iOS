//
//  SignUpController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class SignUpViewController: UIViewController {
    
    let signUpLabel = UILabel()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let checkExistenceButton = UIButton()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let checkPasswordValidButton = CheckButton()
    let passwordConfirmLabel = UILabel()
    let passwordConfirmTextField = UITextField()
    let checkPasswordSameButton = CheckButton()
    let signUpButton = UIButton()
    
    var isButtonActivate: Bool = false {
        didSet {
            isButtonActivate ? activateUI() : deactivateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerForKeyboardNotification()
        registerTarget()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustView), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func registerTarget() {
        [checkExistenceButton, signUpButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    func activateUI() {
        signUpButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x00A3FF), for: .normal)
        signUpButton.isEnabled = true
        emailTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        emailTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    func deactivateUI() {
        signUpButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0xECEEF0), for: .normal)
        signUpButton.isEnabled = false
        emailTextField.returnKeyType = .default
        passwordTextField.returnKeyType = .default
        emailTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
}

extension SignUpViewController {
    
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationController?.do {
            $0.isNavigationBarHidden = false
        }
        
        signUpLabel.do {
            $0.text = "SIGN UP"
            $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        }
        
        emailLabel.do {
            $0.text = "E-MAIL"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        emailTextField.do {
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3F5F7)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.keyboardType = .alphabet
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
        }
        
        checkExistenceButton.do {
            $0.setTitle("중복확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            $0.setBackgroundColor(.red, for: .normal)
        }

        passwordLabel.do {
            $0.text = "PASSWORD"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        passwordTextField.do {
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3F5F7)
            $0.isSecureTextEntry = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
        }
        
        checkPasswordValidButton.do {
            $0.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            $0.isSelected = false
            $0.isEnabled = false
        }
        
        passwordConfirmLabel.do {
            $0.text = "CONFIRM PASSWORD"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        passwordConfirmTextField.do {
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3F5F7)
            $0.isSecureTextEntry = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
        }
        
        checkPasswordSameButton.do {
            $0.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            $0.isSelected = false
            $0.isEnabled = false
        }

        signUpButton.do {
            $0.setTitle("OK", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0xB5B9BD), for: .disabled)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            $0.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x00A3FF), for: .normal)
            $0.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0xECEEF0), for: .disabled)
            $0.isEnabled = false
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubViews(signUpLabel, emailLabel, emailTextField, checkExistenceButton, passwordLabel, passwordTextField, checkPasswordValidButton, passwordConfirmLabel, passwordConfirmTextField, checkPasswordSameButton, signUpButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(checkExistenceButton.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        checkExistenceButton.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(checkPasswordValidButton.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        checkPasswordValidButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        passwordConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        passwordConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(passwordConfirmLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(checkPasswordSameButton.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        checkPasswordSameButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordConfirmTextField)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    @objc private func adjustView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }

        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let adjustmentHeight = keyboardFrame.height

        if noti.name == UIResponder.keyboardWillShowNotification {
            signUpButton.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(-adjustmentHeight)
            }
        } else {
            signUpButton.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if emailTextField.text != "", passwordTextField.text != "", passwordConfirmTextField.text != "" {
            isButtonActivate = true
        } else {
            isButtonActivate = false
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case checkExistenceButton:
            print("check")
        case signUpButton:
            print("sign Up")
        default:
            return
        }
    }
}
