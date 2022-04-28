//
//  SplashViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/17.
//

import UIKit

class SplashViewController: UIViewController {
    private let logoView = UIImageView()
    private var mTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isAutoLogin)
        UserDefaults.standard.setValue(true, forKey: UserDefaultKey.isNotFirstTime)

        mTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    private func setupViewLayout() {
        view.backgroundColor = .white
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(104)
        }
        logoView.image = Image.navyShapeCircle
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
