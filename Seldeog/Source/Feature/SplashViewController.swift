//
//  SplashViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/17.
//

import UIKit

class SplashViewController: UIViewController {
    private let logoView = UIImageView()
    private let logoImageView = UIImageView(image: Image.logoGIF)
    private let seldukImageView = UIImageView(image: Image.selduk)

    private var mTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        mTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    private func setupViewLayout() {

        view.backgroundColor = .white
        logoImageView.backgroundColor = .white
        
        view.addSubview(logoView)
        logoView.addSubviews(logoImageView, seldukImageView)
        
        logoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(112)
            $0.height.equalTo(116)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(76)
        }
        
        seldukImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(112)
            $0.height.equalTo(29)
        }
    }

    private func processCheck() {
        if UserDefaults.standard.bool(forKey: UserDefaultKey.isAutoLogin) {
            UserDefaults.standard.setValue(true, forKey: UserDefaultKey.loginStatus)
        } else {
            UserDefaults.standard.setValue(false, forKey: UserDefaultKey.loginStatus)
        }

        LoginSwitcher.updateRootVC(root: .calendar)
    }
    
    @objc func timerAction(timer _: Timer) {
        processCheck()
    }
}
