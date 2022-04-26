//
//  SelectColorViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/01.
//

import UIKit

import SnapKit

final class SelectColorViewController: BaseViewController {
    
    let characterLabel = UILabel()
    let loadingBar = UIProgressView()
    let titleLabel = UILabel()
    let containerView = UIView()
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let nextButton = UIButton()
    let popButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        return cv
    }()
    
    var cellImageList = [Image.colorNavy, Image.colorYellow, Image.colorPink, Image.colorMauve, Image.colorGreen]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
        setLoadingBarAnimation()
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func setLoadingBarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingBar.setProgress(1 / 2, animated: true)
        }
    }
    
}

extension SelectColorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? SelectColorCell else { return UICollectionViewCell() }
        
        cell.setImage(image: cellImageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shapeIndex = CharacterData.selectedShapeIndex
        self.shapeImageView.image = CharacterData.colorShapeImageList[shapeIndex - 1][indexPath.item]
        CharacterData.selectedColorWithShape = CharacterData.colorShapeImageList[shapeIndex - 1][indexPath.item]
        CharacterData.selectedColorIndex = indexPath.item + 1
    }
}

extension SelectColorViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        navigationItem.do {
            $0.hidesBackButton = false
        }
        
        characterLabel.do {
            $0.text = "MY CHARACTER"
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        loadingBar.do {
            $0.layer.cornerRadius = 8.5
            $0.clipsToBounds = true
            $0.layer.sublayers![1].cornerRadius = 8.5
            $0.subviews[1].clipsToBounds = true
            $0.progress = 1 / 4
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "2. COLOR"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 30, family: .bold)
        }
        
        shapeImageView.do {
            $0.image = CharacterData.selectedShape
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expressionSmile
            $0.contentMode = .scaleToFill
        }
        
        collectionView.do {
            $0.register(SelectColorCell.self, forCellWithReuseIdentifier: "ColorCell")
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            $0.showsHorizontalScrollIndicator = false
        }
        
        nextButton.do {
            $0.setTitle("NEXT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 30, family: .bold)
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
        view.addSubviews(characterLabel, loadingBar, titleLabel, containerView, collectionView, nextButton)
        containerView.addSubview(shapeImageView)
        shapeImageView.addSubview(expressionImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        characterLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.centerX.equalToSuperview()
        }

        loadingBar.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(collectionView.snp.top)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalTo(nextButton.snp.top).offset(-50)
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
        case popButton:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
}
