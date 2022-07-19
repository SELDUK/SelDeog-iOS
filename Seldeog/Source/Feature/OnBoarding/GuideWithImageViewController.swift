//
//  GuideWithImageViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/05/01.
//

import UIKit

import SnapKit

final class GuideWithImageViewController: UIViewController {
    
    private let backgroundImageView = UIImageView()

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
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
