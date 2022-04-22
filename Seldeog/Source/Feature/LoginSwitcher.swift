//
//  LoginSwitcher.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/17.
//

import UIKit

class LoginSwitcher {

    static func updateRootVC(root: UpdateRoot) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            if UserDefaults.standard.bool(forKey: UserDefaultKey.loginStatus) {
                if UserDefaults.standard.bool(forKey: UserDefaultKey.isNotFirstTime) {
                    switch root {
                    case .calendar:
                        sceneDelegate.goToCalendarVC()
                    case .setting:
                        sceneDelegate.goToSettingVC()
                    case .aboutMe:
                        sceneDelegate.goToAboutMeVC()
                    case .selfLove:
                        sceneDelegate.goToSelfLoveVC()
                    case .signIn:
                        sceneDelegate.goToSignIn()
                    case .onBoard:
                        sceneDelegate.goToOnboard()
                    }
                } else {
                    sceneDelegate.goToOnboard()
                }
            } else {
                sceneDelegate.goToSignIn()
            }
        }
    }
}

public enum UpdateRoot {
    case calendar
    case setting
    case aboutMe
    case selfLove
    case signIn
    case onBoard
}
