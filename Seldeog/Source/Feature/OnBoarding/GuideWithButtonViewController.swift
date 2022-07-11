//
//  GuideWithButtonViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/05/01.
//

import UIKit

final class GuideWithButtonViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    let nextButton = UIButton().then {
        $0.setTitle("START", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .nanumPen(size: 30, family: .bold)
        $0.setBackgroundColor(UIColor.colorWithRGBHex(hex: 0x4c6599), for: .normal)
        $0.addTarget(GuideWithButtonViewController.self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }

    init(image: UIImage) {
        self.backgroundImageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
    }
    
    private func setLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(nextButton)
        backgroundImageView.bringSubviewToFront(nextButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func nextButtonDidTap() {
        LoginSwitcher.updateRootVC(root: .calendar)
    }
    
}
