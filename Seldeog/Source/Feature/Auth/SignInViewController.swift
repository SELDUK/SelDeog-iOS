//
//  SignInViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class SignInViewController: BaseViewController {
    
    let signInLabel = UILabel()
    let warningLabel = UILabel()
    let idImageView = UIImageView()
    let idTextField = UITextField()
    let idTextFieldLineView = UIView()
    let passwordImageView = UIImageView()
    let passwordTextField = UITextField()
    let passwordTextFieldLineView = UIView()
    let autoLoginButton = CheckButton()
    let autoLoginLabel = UILabel()
    let signUpContainerView = UIView()
    let signUpLabel = UILabel()
    let signUpLineView = UIView()
    let signUpButton = UIButton()
    let signInButton = UIButton()
    let dismissButton = UIButton()
    let copyRightLabel = UILabel()
    let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font : UIFont.nanumPen(size: 20, family: .bold)
    ]
    
    var isButtonActivate: Bool = false {
        didSet {
            isButtonActivate ? activateUI() : deactivateUI()
        }
    }
    
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
        [autoLoginButton, signUpButton, signInButton, dismissButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func activateUI() {
        signInButton.setBackgroundColor(UIColor.black, for: .normal)
        signInButton.isEnabled = true
        idTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        idTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    private func deactivateUI() {
        signInButton.isEnabled = false
        idTextField.returnKeyType = .default
        passwordTextField.returnKeyType = .default
        idTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    private func signIn() {
        guard let email = self.idTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        postSignIn(email: email, password: password) { data in
            if data.success {
                if self.autoLoginButton.isSelected {
                    UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isAutoLogin)
                } else {
                    UserDefaults.standard.setValue(false, forKey: UserDefaultKey.isAutoLogin)
                }
                
                if let token = data.data?.token {
                    UserDefaults.standard.setValue(token, forKey: UserDefaultKey.token)
                }
                
                UserDefaults.standard.setValue(true, forKey: UserDefaultKey.loginStatus)
                UserDefaults.standard.synchronize()
                LoginSwitcher.updateRootVC()
            } else {
                self.warningLabel.textColor = UIColor.red.withAlphaComponent(1)
            }
        }
    }
    
    func postSignIn(
        email: String,
        password: String,
        completion: @escaping (AuthResponse) -> Void
    ) {
        AuthRepository.shared.postSignIn(email: email,
                                         password: password) { result in
            switch result {
            case .success(let response):
                print(response)
                guard let data = response as? AuthResponse else { return }
                completion(data)
            default:
                print("sign in error")
            }
        }
    }

}

extension SignInViewController {
    
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationController?.do {
            $0.isNavigationBarHidden = false
            let dismissBarButton = UIBarButtonItem(customView: dismissButton)
            navigationItem.setHidesBackButton(true, animated: true)
            navigationItem.rightBarButtonItem = dismissBarButton
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        signInLabel.do {
            $0.text = "SIGN IN"
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        warningLabel.do {
            $0.text = "THE ID OR PASSWORD DOES NOT MATCH"
            $0.font = .nanumPen(size: 13, family: .bold)
            $0.textColor = UIColor.red.withAlphaComponent(0)
        }
        
        idImageView.do {
            $0.image = Image.idImage
        }
        
        idTextField.do {
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "ID", attributes: attributes)
            $0.clearButtonMode = .never
            $0.keyboardType = .alphabet
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        idTextFieldLineView.do {
            $0.backgroundColor = .black
        }

        passwordImageView.do {
            $0.image = Image.passwordImage
        }
        
        passwordTextField.do {
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: attributes)
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        passwordTextFieldLineView.do {
            $0.backgroundColor = .black
        }
        
        autoLoginButton.do {
            $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            $0.isSelected = false
        }
        
        autoLoginLabel.do {
            $0.text = "자동로그인"
            $0.font = .nanumPen(size: 13, family: .bold)
            $0.textColor = UIColor.black
        }
        
        signUpLabel.do {
            $0.text = "DON’T HAVE AN ACCOUNT?"
            $0.font = .nanumPen(size: 13, family: .bold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0xAAAAAA)
        }
        
        signUpLineView.do {
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0x005982)
        }
        
        signUpButton.do {
            $0.setTitle("SIGN UP", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x005982), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 15, family: .bold)
        }

        signInButton.do {
            $0.setTitle("SIGN IN", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 20, family: .bold)
            $0.setBackgroundColor(.black, for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.isEnabled = false
        }
        
        copyRightLabel.do {
            $0.text = "Copyright 2022. KGB Co., Ltd. all rights reserved."
            $0.font = .nanumPen(size: 10, family: .regular)
        }

        dismissButton.do {
            $0.setImage(Image.xLine, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(signInLabel, warningLabel, idImageView, idTextField, idTextFieldLineView, passwordImageView, passwordTextField, passwordTextFieldLineView, autoLoginButton, autoLoginLabel, signInButton, signUpContainerView, copyRightLabel)
        signUpContainerView.addSubviews(signUpLabel, signUpLineView, signUpButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        signInLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(signInLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        idImageView.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(30)
            $0.width.height.equalTo(25)
        }

        idTextField.snp.makeConstraints {
            $0.centerY.equalTo(idImageView)
            $0.leading.equalTo(idImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        idTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }

        passwordImageView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(34)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(21)
            $0.height.equalTo(27)
        }

        passwordTextField.snp.makeConstraints {
            $0.centerY.equalTo(passwordImageView)
            $0.leading.equalTo(passwordImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        passwordTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        autoLoginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(19)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
        
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginButton)
            $0.trailing.equalTo(autoLoginButton.snp.leading).offset(-5)
        }

        signInButton.snp.makeConstraints {
            $0.top.equalTo(autoLoginButton.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        signUpContainerView.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        signUpLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        signUpLineView.snp.makeConstraints {
            $0.leading.equalTo(signUpLabel.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(3)
            $0.height.equalTo(14)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(signUpLineView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        copyRightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeArea).offset(-67)
        }
        
    }
    
    @objc func textFieldDidChange() {
        if idTextField.text != "", passwordTextField.text != "" {
            isButtonActivate = true
        } else {
            isButtonActivate = false
        }
        self.warningLabel.textColor = UIColor.red.withAlphaComponent(0)
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case autoLoginButton:
            autoLoginButton.isSelected = !autoLoginButton.isSelected
        case signUpButton:
            navigationController?.pushViewController(SignUpViewController(), animated: false)
        case signInButton:
            signIn()
        case dismissButton:
            dismiss(animated: true, completion: nil)
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
            if textField == idTextField {
                passwordTextField.becomeFirstResponder()
            } else if textField == passwordTextField {
                idTextField.becomeFirstResponder()
            } else {
                return false
            }
            return true
        }
    }
}
