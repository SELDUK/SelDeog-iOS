//
//  AboutMeVIewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/19.
//

import UIKit
import SnapKit
import Kingfisher

protocol AboutMeButtonProtocol {
    func modifyComment(serverIndex: Int, cellIndex: Int)
    func deleteComment(index: Int)
}

final class AboutMeViewController: BaseViewController {

    let titleLabel = UILabel()
    let writeButton = UIButton()
    let lineView = UIView()
    let countLabel = UILabel()
    let newFilterLabel = UILabel()
    let newFilterButton = UIButton()
    let tableView = UITableView()
    let baseTabBarView = BaseTabBarView()
    var featureList: [UserCharacterComment] = [UserCharacterComment(usrChrCmtIdx: 1, usrChrCmt: "가나다라마바사아자차카타파하아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아ㅏ아아아아아아아아ㅏ아ㅏ아아아아아아아아아아아아아아아아아아아아아아ㅏ아아아",usrCmtTags: ["1"]), UserCharacterComment(usrChrCmtIdx: 2, usrChrCmt: "하이", usrCmtTags: ["2"])]

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func registerTarget() {
        [writeButton, baseTabBarView.calendarButton, baseTabBarView.aboutMeButton, baseTabBarView.selfLoveButton, baseTabBarView.settingButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }

}

extension AboutMeViewController: UITableViewDelegate, UITableViewDataSource, CommentButtonProtocol {

    func modifyComment(serverIndex: Int, cellIndex: Int) {

    }

    func deleteComment(index: Int) {
        setAlertConfirmAndCancel(index: index, message: "삭제된 칭찬은 복구되지 않습니다. 칭찬을 정말 삭제하시겠습니까?")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeCell", for: indexPath) as? AboutMeCell else { return UITableViewCell() }
        
        cell.setCellIndex(index: indexPath.item + 1)
        cell.setCommentIndex(index: featureList[indexPath.item].usrChrCmtIdx)
        cell.setCompliment(text: featureList[indexPath.item].usrChrCmt)
        cell.setDate(text: "2022-04-20")
        cell.buttonDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
}

extension AboutMeViewController {

    private func setProperties() {

        view.do {
            $0.backgroundColor = .white
        }

        navigationItem.do {
            $0.hidesBackButton = true
        }
        
        titleLabel.do {
            $0.text = "ABOUT ME"
            $0.font = .nanumPen(size: 35, family: .bold)
        }

        writeButton.do {
            $0.setBackgroundColor(.black, for: .normal)
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.tintColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }

        lineView.do {
            $0.backgroundColor = .black
        }
        
        countLabel.do {
            $0.font = .nanumPen(size: 15, family: .bold)
            $0.text = "총 2개"
        }
        
        newFilterLabel.do {
            $0.text = "최신순으로 보기"
            $0.font = .nanumPen(size: 13, family: .bold)
        }
        
        newFilterButton.do {
            $0.setImage(Image.checkButton, for: .normal)
            $0.setImage(Image.checkButtonClicked, for: .selected)
        }
        
        tableView.do {
            $0.register(AboutMeCell.self, forCellReuseIdentifier: "AboutMeCell")
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 78
            $0.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            $0.separatorStyle = .none
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
        }
    }

    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }

    private func setViewHierarchy() {
        view.addSubviews(titleLabel, writeButton, lineView, countLabel, newFilterLabel, newFilterButton, tableView, baseTabBarView)
    }

    private func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }

        writeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(30)
        }

        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }

        newFilterButton.snp.makeConstraints {
            $0.centerY.equalTo(countLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(16)
        }
        
        newFilterLabel.snp.makeConstraints {
            $0.centerY.equalTo(countLabel)
            $0.trailing.equalTo(newFilterButton.snp.leading).offset(-8)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(baseTabBarView.snp.top)
        }

        baseTabBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }

    }

    func setAlertConfirmAndCancel(index: Int, message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
//            self.deleteCommentIndex(usrChrCmtIdx: index)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }


    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case writeButton:
            navigationController?.pushViewController(WriteComplimentViewController(), animated: false)
        case baseTabBarView.calendarButton:
            navigationController?.popViewController(animated: false)
        case baseTabBarView.aboutMeButton:
            navigationController?.pushViewController(WriteComplimentViewController(), animated: false)
        case baseTabBarView.selfLoveButton:
            navigationController?.pushViewController(SignUpViewController(), animated: false)
        case baseTabBarView.settingButton:
            navigationController?.pushViewController(SettingViewController(), animated: false)
        default:
            return
        }
    }

}
