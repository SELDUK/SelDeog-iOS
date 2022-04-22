//
//  SelfLoveViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/22.
//

import UIKit
import SnapKit
import Lottie

final class SelfLoveViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let percentageLabel = UILabel()
    let animationView = AnimationView()
    let baseTabBarView = BaseTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
    }
    
    private func registerTarget() {
        [baseTabBarView.calendarButton, baseTabBarView.settingButton, baseTabBarView.aboutMeButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
}

extension SelfLoveViewController {
    
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.text = "HOW MUCH \nDO YOU LOVE YOU?"
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.font = .nanumPen(size: 35, family: .bold)
            $0.textAlignment = .center
        }
        
        descriptionLabel.do {
            $0.text = "애정도는 칭찬 개수와 빈도수를 측정하여 계산됩니다"
            $0.textColor = .black
            $0.font = .nanumPen(size: 11, family: .bold)
            $0.textAlignment = .center
        }
        
        percentageLabel.do {
            $0.text = "25%"
            $0.font = .nanumPen(size: 50, family: .bold)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        baseTabBarView.selfLoveButton.do {
            $0.setImage(Image.loveIconClicked, for: .normal)
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(titleLabel, descriptionLabel, percentageLabel, baseTabBarView)
    }
    
    private func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(147)
            $0.centerX.equalToSuperview()
        }
        
        baseTabBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case baseTabBarView.calendarButton:
            LoginSwitcher.updateRootVC(root: .calendar)
        case baseTabBarView.settingButton:
            LoginSwitcher.updateRootVC(root: .setting)
        case baseTabBarView.aboutMeButton:
            LoginSwitcher.updateRootVC(root: .aboutMe)
        default:
            return
        }
    }
}
