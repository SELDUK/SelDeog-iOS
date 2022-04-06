//
//  ConfirmCharacterViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/25.
//

import UIKit

import Lottie
import SnapKit

final class ConfirmCharacterViewController: BaseViewController {
    
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let featureImageView = UIImageView()
    let sayHiLabel = UILabel()
    let pleaseLoveMeLabel = UILabel()
    let nextButton = UIButton()
    let popButton = UIButton()
//    let animationView = AnimationView(name: "폭죽")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }

//    private func setAnimation() {
//        animationView.contentMode = .scaleAspectFit
//        animationView.frame = view.bounds
//        animationView.play()
//        animationView.loopMode = .loop
//    }
}

extension ConfirmCharacterViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationController?.do {
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.isTranslucent = true
        }
        
        navigationItem.do {
            $0.leftBarButtonItem = UIBarButtonItem(customView: popButton)
        }
        
        shapeImageView.do {
            $0.image = CharacterData.selectedShape
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expressionSmile
            $0.contentMode = .scaleToFill
        }
        
        featureImageView.do {
            $0.image = CharacterData.selectedFeature
            $0.contentMode = .scaleToFill
        }
        
        sayHiLabel.do {
            if let nickname = CharacterData.nickname{
                $0.text = "HI! I'M ''\(nickname)''"
            }
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        pleaseLoveMeLabel.do {
            $0.text = "PLEASE LOVE ME"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        nextButton.do {
            $0.setTitle("OK", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 25, family: .bold)
        }
        
        popButton.do {
            $0.setImage(Image.arrowLeftIcon, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(sayHiLabel, pleaseLoveMeLabel, shapeImageView, nextButton)
        shapeImageView.addSubviews(expressionImageView, featureImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
        expressionImageView.bringSubviewToFront(featureImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        sayHiLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(120)
            $0.centerX.equalToSuperview()
        }
        
        pleaseLoveMeLabel.snp.makeConstraints {
            $0.top.equalTo(sayHiLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        shapeImageView.snp.makeConstraints {
            $0.top.equalTo(pleaseLoveMeLabel.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
        }
        
        featureImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(231)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(80)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case nextButton:
            print()
        case popButton:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
}
