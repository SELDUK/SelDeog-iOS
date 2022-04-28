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
    var animationView: AnimationView?
    let baseTabBarView = BaseTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLovePercentage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pauseAnimation()
    }
    
    private func getLovePercentage() {
        getSelfLove() { data in
            if data.success {
                self.percentageLabel.text = "\(data.data.usrChrLove)%"
                switch data.data.usrChrLove {
                case 98:
                    self.animationView = Animation.ninetyeightPercentage
                case 90...97:
                    self.animationView = Animation.ninetyPercentage
                case 80...89:
                    self.animationView = Animation.eightyPercentage
                case 70...79:
                    self.animationView = Animation.seventyPercentage
                case 60...69:
                    self.animationView = Animation.sixtyPercentage
                case 50...59:
                    self.animationView = Animation.fiftyPercentage
                case 40...49:
                    self.animationView = Animation.fourtyPercentage
                case 30...39:
                    self.animationView = Animation.thirtyPercentage
                case 20...29:
                    self.animationView = Animation.twentyPercentage
                default:
                    self.animationView = Animation.tenPercentage
                }
                
                guard let animationView = self.animationView else { return }

                self.view.addSubview(animationView)
                
                animationView.snp.makeConstraints {
                    $0.top.equalTo(self.descriptionLabel.snp.bottom)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.width.equalTo(281)
                    $0.height.equalTo(293)
                }
                animationView.contentMode = .scaleAspectFill
                animationView.play()
                animationView.loopMode = .playOnce
                animationView.layer.zPosition = -1
            } else {
                self.showToastMessageAlert(message: "Self Love 로드에 실패하였습니다.")
            }
        }
    }
    
    func getSelfLove(
        completion: @escaping (SelfLoveResponse) -> Void
    ) {
        UserRepository.shared.getSelfLove() { result in
            switch result {
            case .success(let response):
                print(response)
                guard let data = response as? SelfLoveResponse else { return }
                completion(data)
            default:
                print("API error")
            }
        }
    }
    
    private func pauseAnimation() {
        guard let animationView = self.animationView else { return }
        animationView.removeFromSuperview()
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
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(137)
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
