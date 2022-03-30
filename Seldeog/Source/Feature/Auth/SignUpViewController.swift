//
//  SignUpController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/02.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class SignUpViewController: BaseViewController {
    
    let signUpLabel = UILabel()
    let idImageView = UIImageView()
    let idTextField = UITextField()
    let idTextFieldLineView = UIView()
    let checkExistenceButton = UIButton()
    let passwordImageView = UIImageView()
    let passwordTextField = UITextField()
    let passwordTextFieldLineView = UIView()
    let checkPasswordValidView = UIImageView()
    let passwordConfirmImageView = UIImageView()
    let passwordConfirmTextField = UITextField()
    let passwordConfirmTextFieldLineView = UIView()
    let checkPasswordSameView = UIImageView()
    let signUpButton = UIButton()
    let signInContainerView = UIView()
    let signInLabel = UILabel()
    let signInLineView = UIView()
    let signInButton = UIButton()
    let dismissButton = UIButton()
    let copyRightLabel = UILabel()
    let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font : UIFont.nanumPen(size: 20, family: .bold)
    ]

    let disposeBag = DisposeBag()
    
    var isIDValid: Bool = false
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
        checkValidate()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    private func registerTarget() {
        [checkExistenceButton, signUpButton, dismissButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    func activateUI() {
        signUpButton.isEnabled = true
        idTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        idTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    func deactivateUI() {
        signUpButton.isEnabled = false
        idTextField.returnKeyType = .default
        passwordTextField.returnKeyType = .default
        idTextField.reloadInputViews()
        passwordTextField.reloadInputViews()
    }
    
    func checkValidate() {
        let passwordText = passwordTextField.rx.text.orEmpty.distinctUntilChanged()
        let passwordConfirmText = passwordConfirmTextField.rx.text.orEmpty.distinctUntilChanged()
        let isPasswordValid = PublishRelay<Bool>()
        let isPasswordSame = PublishRelay<Bool>()
        
        passwordText
            .map { [weak self] text in
                self?.validatePassword(text: text) ?? false
            }
            .bind { [weak self] bool in
                if bool {
                    self?.checkPasswordValidView.image = Image.validPassword
                    isPasswordValid.accept(true)
                } else {
                    self?.checkPasswordValidView.image = Image.invalidPassword
                    isPasswordValid.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(passwordText, passwordConfirmText)
            .skip(1)
            .map { [weak self] password, passwordConfirm -> Bool in
                guard let self = self else { return false }
                return password == passwordConfirm && self.validatePassword(text: passwordConfirm)
            }
            .bind { [weak self] bool in
                if bool {
                    self?.checkPasswordSameView.image = Image.validPassword
                    isPasswordSame.accept(true)
                } else {
                    self?.checkPasswordSameView.image = Image.invalidPassword
                    isPasswordSame.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(isPasswordValid, isPasswordSame)
            .map { $0 && $1 }
            .subscribe { [weak self] isActivate in
                self?.isButtonActivate = isActivate
            }
            .disposed(by: disposeBag)
    }
    
    func validatePassword(text: String) -> Bool {
        if text.count < 8 {
            return false
        } else {
            return true
        }
    }
    
    func checkExistence() {
        guard let email = self.idTextField.text else { return }
        checkEmailValid(email: email) { data in
            if data.success {
                self.isIDValid = true
                self.showToastMessageAlert(message: "시용가능한 이메일입니다.")
            } else {
                self.showToastMessageAlert(message: "이미 존재한 이메일입니다.")
            }
        }
    }
    
    func signUp() {
        guard let email = self.idTextField.text else { return }
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
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        idImageView.do {
            $0.image = Image.idImage
        }
        
        idTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "ID", attributes: attributes)
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

        idTextFieldLineView.do {
            $0.backgroundColor = .black
        }

        passwordImageView.do {
            $0.image = Image.passwordImage
        }
        
        passwordTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "PASSWORD (6~10자리)", attributes: attributes)
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
        }
        
        passwordTextFieldLineView.do {
            $0.backgroundColor = .black
        }
        
        checkPasswordValidView.do {
            $0.image = Image.invalidPassword
        }
        
        passwordConfirmImageView.do {
            $0.image = Image.checkPasswordImage
        }
        
        passwordConfirmTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "CONFIRM PASSWORD", attributes: attributes)
            $0.isSecureTextEntry = true
            $0.clearButtonMode = .never
            $0.keyboardType = .asciiCapable
            $0.layer.borderWidth = 0
            $0.addLeftPadding()
            $0.autocapitalizationType = .none
        }
        
        passwordConfirmTextFieldLineView.do {
            $0.backgroundColor = .black
        }
        
        checkPasswordSameView.do {
            $0.image = Image.invalidPassword
        }

        signUpButton.do {
            $0.setTitle("SIGN UP", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 20, family: .bold)
            $0.setBackgroundColor(.black, for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.isEnabled = false
        }
        
        signInLabel.do {
            $0.text = "HAVE AN ACCOUNT?"
            $0.font = .nanumPen(size: 13, family: .bold)
            $0.textColor = UIColor.colorWithRGBHex(hex: 0xAAAAAA)
        }
        
        signInLineView.do {
            $0.backgroundColor = UIColor.colorWithRGBHex(hex: 0xAAAAAA)
        }
        
        signInButton.do {
            $0.setTitle("SIGN IN", for: .normal)
            $0.setTitleColor(UIColor.colorWithRGBHex(hex: 0x005982), for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 15, family: .bold)
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
        view.addSubviews(signUpLabel, idImageView, idTextField, idTextFieldLineView, checkExistenceButton, passwordImageView, passwordTextField, passwordTextFieldLineView, checkPasswordValidView, passwordConfirmImageView, passwordConfirmTextField, passwordConfirmTextFieldLineView, checkPasswordSameView, signUpButton, signInContainerView, copyRightLabel)
        signInContainerView.addSubviews(signInLabel, signInLineView, signInButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        idImageView.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(82)
            $0.leading.equalToSuperview().inset(30)
            $0.width.height.equalTo(25)
        }

        idTextField.snp.makeConstraints {
            $0.centerY.equalTo(idImageView)
            $0.leading.equalTo(idImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(checkExistenceButton.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        idTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }

        checkExistenceButton.snp.makeConstraints {
            $0.centerY.equalTo(idTextField)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }

        passwordImageView.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(34)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(21)
            $0.height.equalTo(27)
        }

        passwordTextField.snp.makeConstraints {
            $0.centerY.equalTo(passwordImageView)
            $0.leading.equalTo(passwordImageView.snp.trailing).offset(19)
            $0.trailing.equalTo(checkPasswordValidView.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        passwordTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        checkPasswordValidView.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalToSuperview().offset(-34)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        passwordConfirmImageView.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(21)
            $0.height.equalTo(26)
        }

        passwordConfirmTextField.snp.makeConstraints {
            $0.centerY.equalTo(passwordConfirmImageView)
            $0.leading.equalTo(passwordConfirmImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(checkPasswordSameView.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        passwordConfirmTextFieldLineView.snp.makeConstraints {
            $0.top.equalTo(passwordConfirmTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        checkPasswordSameView.snp.makeConstraints {
            $0.centerY.equalTo(passwordConfirmTextField)
            $0.trailing.equalToSuperview().offset(-34)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(checkPasswordSameView.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        signInContainerView.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        signInLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        signInLineView.snp.makeConstraints {
            $0.leading.equalTo(signInLabel.snp.trailing).offset(9)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(14)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.equalTo(signInLineView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        copyRightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeArea).offset(-67)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case checkExistenceButton:
            checkExistence()
        case signUpButton:
            isIDValid ? signUp() : setAlert(message: "아이디 중복확인을 완료하세요.")
        case dismissButton:
            dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}
