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
    let settingInfoList: [SettingInfo] = [SettingInfo(settingIcon: Image.notificationIcon, settingTitle: "NOTIFICATION"),
                                          SettingInfo(settingIcon: Image.lockIcon, settingTitle: "LOCK"),
                                          SettingInfo(settingIcon: Image.guideIcon, settingTitle: "GUIDE"),
                                          SettingInfo(settingIcon: Image.logoutIcon, settingTitle: "LOG OUT"),
                                          SettingInfo(settingIcon: Image.informationIcon, settingTitle: "APP VERSION")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0, 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSwitchCell", for: indexPath) as? SettingSwitchCell else { return UITableViewCell() }
            cell.setImage(image: settingInfoList[indexPath.row].settingIcon)
            cell.setTitle(title: settingInfoList[indexPath.row].settingTitle)
            cell.selectionStyle = .none
            return cell
        case 2, 3:
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
    
}

extension SettingViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.text = "SETTING"
            $0.font = .nanumPen(size: 35, family: .bold)
        }
        
        lineView.do {
            $0.backgroundColor = .black
        }
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(SettingNextCell.self, forCellReuseIdentifier: "SettingNextCell")
            $0.register(SettingSwitchCell.self, forCellReuseIdentifier: "SettingSwitchCell")
            $0.register(SettingTextCell.self, forCellReuseIdentifier: "SettingTextCell")
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(titleLabel, lineView, tableView)
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
            $0.bottom.equalTo(safeArea)
        }
    }
    
}