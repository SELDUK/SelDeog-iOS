//
//  SignUpController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class SignUpViewController: BaseViewController {
    
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
    let dismissButton = UIButton()
    
    var isEmailValid: Bool = false
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
        [checkExistenceButton, signUpButton, dismissButton].forEach {
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
    
    func checkExistence() {
        guard let email = self.emailTextField.text else { return }
        checkEmailValid(email: email) { data in
            if data.success {
                self.isEmailValid = true
                self.showToastMessageAlert(message: "시용가능한 이메일입니다.")
            } else {
                self.showToastMessageAlert(message: "이미 존재한 이메일입니다.")
            }
        }
    }
    
    func signUp() {
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        postSignUp(email: email, password: password) { data in
            if data.success {
                self.setAlert(message: "회원가입 완료!!")
            } else {
                self.showToastMessageAlert(message: "회원가입에 실패하였습니다.")
            }
        }
    }

    func checkEmailValid(
        email: String,
        completion: @escaping (AuthResponse) -> Void
    ) {
        AuthRepository.shared.checkEmailValid(email: email) { result in
            switch result {
            case .success(let response):
                print(response)
                guard let data = response as? AuthResponse else { return }
                completion(data)
            default:
                print("check mail error")
            }
        }
    }

    func postSignUp(
        email: String,
        password: String,
        completion: @escaping (AuthResponse) -> Void
    ) {
        AuthRepository.shared.postSignUp(email: email,
                                         password: password) { result in
            switch result {
            case .success(let response):
                print(response)
                guard let data = response as? AuthResponse else { return }
                completion(data)
            default:
                print("sign up error")
            }
        }
    }

}

extension SignUpViewController {
    
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
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
            $0.textContentType = .newPassword
            $0.isSecureTextEntry = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
            $0.textContentType = .newPassword
            $0.isSecureTextEntry = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.clearButtonMode = .never
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        
        dismissButton.do {
            $0.setImage(Image.xLine, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(signUpLabel, emailLabel, emailTextField, checkExistenceButton, passwordLabel, passwordTextField, checkPasswordValidButton, passwordConfirmLabel, passwordConfirmTextField, checkPasswordSameButton, signUpButton)
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
        if let text = passwordTextField.text {
            if text.count < 8 {
                checkPasswordValidButton.isSelected = false
            } else {
                checkPasswordValidButton.isSelected = true
            }
        }
        
        if let passwordText = passwordTextField.text, let passwordConfirmText = passwordConfirmTextField.text {
            if passwordText == passwordConfirmText, passwordText != "" {
                checkPasswordSameButton.isSelected = true
            } else {
                checkPasswordSameButton.isSelected = false
            }
        }
        
        if checkPasswordSameButton.isSelected,
           checkPasswordValidButton.isSelected,
            isEmailValid {
            isButtonActivate = true
        } else {
            isButtonActivate = false
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case checkExistenceButton:
            checkExistence()
        case signUpButton:
            signUp()
        case dismissButton:
            dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}
