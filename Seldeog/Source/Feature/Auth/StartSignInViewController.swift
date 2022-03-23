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
    
    let signInButton = UIButton()
    let signUpButton = UIButton()

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
        
        signInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x00A3FF), for: .normal)
            $0.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
        }
        
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0xE1F2FE), for: .normal)
            $0.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(signInButton, signUpButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-16)
            $0.height.equalTo(48)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeArea).offset(-32)
            $0.height.equalTo(48)
        }
    }
    
    @objc private func signInButtonTap() {
        let navigationViewController = UINavigationController(rootViewController: SignInViewController())
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }

    @objc private func signUpButtonTap() {
        let navigationViewController = UINavigationController(rootViewController: SignUpViewController())
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }
    
}

