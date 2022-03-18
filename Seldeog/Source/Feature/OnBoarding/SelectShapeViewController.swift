//
//  SelectShapeViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/14.
//

import UIKit

import SnapKit

final class SelectShapeViewController: BaseViewController {
    
    let myCharacterLabel = UILabel()
    let loadingBar = UIImageView()
    let titleLabel = UILabel()
    let characterImageView = UIImageView()
    let expressionImageView = UIImageView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
    
}

extension SelectShapeViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = UIColor(patternImage: Image.checkPattern)
        }
        
        navigationController?.do {
            $0.navigationBar.setBackgroundImage(Image.checkPattern, for: .default)
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.isTranslucent = true
        }
        
        myCharacterLabel.do {
            $0.text = "MY CHARACTER"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        loadingBar.do {
            $0.image = Image.progressBar
        }
        
        titleLabel.do {
            $0.text = "1. SHAPE"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 20, family: .bold)
        }
        
        characterImageView.do {
            $0.image = Image.shapeCircle
        }
        
        expressionImageView.do {
            $0.image = Image.expressionBlank
        }
        
        collectionView.do {
            $0.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            $0.showsHorizontalScrollIndicator = false
        }
        
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubViews(myCharacterLabel, loadingBar, titleLabel, characterImageView, expressionImageView, collectionView)
        characterImageView.bringSubviewToFront(expressionImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        myCharacterLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        loadingBar.snp.makeConstraints {
            $0.top.equalTo(myCharacterLabel.snp.bottom).offset(26)
            $0.leading.equalTo(safeArea).offset(54)
            $0.width.equalTo(74)
            $0.height.equalTo(29)
        }
    }
}

