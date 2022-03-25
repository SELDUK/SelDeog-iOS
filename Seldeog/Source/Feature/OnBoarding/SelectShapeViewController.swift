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
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let nextButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        return cv
    }()
    
    var cellImageList = [Image.shapeCircle, Image.shapeHeart, Image.shapeDent, Image.shapeRock, Image.shapeCloud, Image.shapeUglyHeart]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
    
}

extension SelectShapeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeCharacterCell", for: indexPath) as? MakeCharacterViewCell else { return UICollectionViewCell() }
        
        cell.setImage(image: cellImageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.shapeImageView.image = cellImageList[indexPath.item]
        CharacterData.selectedShape = cellImageList[indexPath.item]
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
        
        navigationItem.do {
            $0.hidesBackButton = true
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
            $0.font = .nanumPen(size: 25, family: .bold)
        }
        
        shapeImageView.do {
            $0.image = Image.shapeCircle
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expressionBlank
            $0.contentMode = .scaleToFill
        }
        
        collectionView.do {
            $0.register(MakeCharacterViewCell.self, forCellWithReuseIdentifier: "MakeCharacterCell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor(patternImage: Image.checkPattern)
            $0.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            $0.showsHorizontalScrollIndicator = false
        }
        
        nextButton.do {
            $0.setTitle("OK", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 25, family: .bold)
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
        
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(myCharacterLabel, loadingBar, titleLabel, shapeImageView, collectionView, nextButton)
        shapeImageView.addSubview(expressionImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
        
        shapeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(shapeImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(120)
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
            let selectFeatureViewController = SelectFeatureViewController()
            navigationController?.pushViewController(selectFeatureViewController, animated: false)
        default:
            return
        }
    }
}
