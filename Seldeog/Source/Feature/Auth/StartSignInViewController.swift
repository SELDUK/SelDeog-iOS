//
//  ViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/02/18.
//

import UIKit

import SnapKit
import Then

final class StartSignInViewController: BaseViewController {
    
    let logoView = UIView()
    let logoLabel = UILabel()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    let copyRightLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
}

extension StartSignInViewController {
    
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationController?.do {
            $0.isNavigationBarHidden = true
        }
        
        logoLabel.do {
            $0.text = "SELDUK"
            $0.textColor = .black
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        signInButton.do {
            $0.setTitle("SIGN IN", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 20, family: .bold)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.setBackgroundColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
        }
        
        signUpButton.do {
            $0.setTitle("SIGN UP", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 20, family: .bold)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.setBackgroundColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        }
        
        copyRightLabel.do {
            $0.text = "Copyright 2022. KGB Co., Ltd. all rights reserved."
            $0.textColor = .black
            $0.font = .nanumPen(size: 10, family: .regular)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(logoView, signInButton, signUpButton, copyRightLabel)
        logoView.addSubview(logoLabel)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(signInButton.snp.top)
        }
        
        logoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-11)
            $0.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(copyRightLabel.snp.top).offset(-66)
            $0.height.equalTo(50)
        }
        
        copyRightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeArea).offset(-67)
        }
    }
    
    @objc private func signInButtonTap() {
        let navigationViewController = BaseNavigationController(rootViewController: SignInViewController())
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }

    @objc private func signUpButtonTap() {
        let navigationViewController = BaseNavigationController(rootViewController: SignUpViewController())
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }
    
}

