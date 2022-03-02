//
//  SignInViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class SignInViewController: UIViewController {
    
    let signInLabel = UILabel()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let autoLoginButton = CheckButton()
    let autoLoginLabel = UILabel()
    let signUpButton = UIButton()
    let signInButton = UIButton()
    
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
        [autoLoginButton, signUpButton, signInButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    func activateUI() {
        signInButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x00A3FF), for: .normal)
        signInButton.isEnabled = true
        emailTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        emailTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    func deactivateUI() {
        signInButton.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0xECEEF0), for: .normal)
        signInButton.isEnabled = false
        emailTextField.returnKeyType = .default
        passwordTextField.returnKeyType = .default
        emailTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }

}

extension SignInViewController {
    
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationController?.do {
            $0.isNavigationBarHidden = false
        }
        
        signInLabel.do {
            $0.text = "SIGN IN"
            $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        }
        
        emailLabel.do {
            $0.text = "E-MAIL"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        emailTextField.do {
            $0.becomeFirstResponder()
            $0.delegate = self
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3F5F7)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.keyboardType = .alphabet
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }

        passwordLabel.do {
            $0.text = "PASSWORD"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        passwordTextField.do {
            $0.delegate = self
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3F5F7)
            $0.isSecureTextEntry = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        autoLoginButton.do {
            $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            $0.isSelected = false
        }
        
        autoLoginLabel.do {
            $0.text = "자동로그인"
            $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0x3A3D40)
        }
        
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.blue, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }

        signInButton.do {
            $0.setTitle("LOG IN", for: .normal)
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
        view.addSubViews(signInLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, autoLoginButton, autoLoginLabel, signUpButton, signInButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        signInLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(signInLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        autoLoginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(20)
        }
        
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginButton)
            $0.leading.equalTo(autoLoginButton.snp.trailing).offset(8)
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginButton)
            $0.trailing.equalToSuperview().offset(-20)
        }

        signInButton.snp.makeConstraints {
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
            signInButton.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(-adjustmentHeight)
            }
        } else {
            signInButton.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if emailTextField.text != "", passwordTextField.text != "" {
            isButtonActivate = true
        } else {
            isButtonActivate = false
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case autoLoginButton:
            autoLoginButton.isSelected = !autoLoginButton.isSelected
        case signUpButton:
            print("sign Up")
        case signInButton:
            print("sign In")
        default:
            return
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            return true
        } else {
            textField.resignFirstResponder()
            if textField == emailTextField {
                passwordTextField.becomeFirstResponder()
            } else if textField == passwordTextField {
                emailTextField.becomeFirstResponder()
            } else {
                return false
            }
            return true
        }
    }
}
