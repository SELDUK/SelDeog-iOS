//
//  SettingViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/06.
//

import UIKit
import SnapKit

final class SettingViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let lineView = UIView()
    let tableView = UITableView()
    let baseTabBarView = BaseTabBarView()
    let settingInfoList: [SettingInfo] = [SettingInfo(settingIcon: Image.guideIcon, settingTitle: "GUIDE"),
                                          SettingInfo(settingIcon: Image.logoutIcon, settingTitle: "LOG OUT"),
                                          SettingInfo(settingIcon: Image.informationIcon, settingTitle: "APP VERSION")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
    }
    
    private func registerTarget() {
        [baseTabBarView.calendarButton, baseTabBarView.selfLoveButton, baseTabBarView.aboutMeButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0, 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingNextCell", for: indexPath) as? SettingNextCell else { return UITableViewCell() }
            cell.setImage(image: settingInfoList[indexPath.row].settingIcon)
            cell.setTitle(title: settingInfoList[indexPath.row].settingTitle)
            cell.selectionStyle = .none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTextCell", for: indexPath) as? SettingTextCell else { return UITableViewCell() }
            cell.setImage(image: settingInfoList[indexPath.row].settingIcon)
            cell.setTitle(title: settingInfoList[indexPath.row].settingTitle)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            LoginSwitcher.updateRootVC(root: .guide)
        case 1:
            UserDefaults.standard.setValue("", forKey: UserDefaultKey.token)
            UserDefaults.standard.setValue(false, forKey: UserDefaultKey.isAutoLogin)
            LoginSwitcher.updateRootVC(root: .signIn)
        default:
            return
        }
    }
    
}

extension SettingViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.text = "SETTING"
            $0.textColor = .black
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        lineView.do {
            $0.backgroundColor = .black
        }
        
        tableView.do {
            $0.backgroundColor = .white
            $0.delegate = self
            $0.dataSource = self
            $0.register(SettingNextCell.self, forCellReuseIdentifier: "SettingNextCell")
            $0.register(SettingTextCell.self, forCellReuseIdentifier: "SettingTextCell")
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
        baseTabBarView.settingButton.do {
            $0.setImage(Image.settingIconClicked, for: .normal)
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(titleLabel, lineView, tableView, baseTabBarView)
    }
    
    private func setConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.leading.trailing.equalTo(safeArea).inset(30)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalTo(baseTabBarView.snp.top)
        }
        
        baseTabBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case baseTabBarView.calendarButton:
            LoginSwitcher.updateRootVC(root: .calendar)
        case baseTabBarView.selfLoveButton:
            LoginSwitcher.updateRootVC(root: .selfLove)
        case baseTabBarView.aboutMeButton:
            LoginSwitcher.updateRootVC(root: .aboutMe)
        default:
            return
        }
    }
    
}
