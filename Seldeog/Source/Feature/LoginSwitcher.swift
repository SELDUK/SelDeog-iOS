//
//  LoginSwitcher.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/17.
//

import UIKit

class LoginSwitcher {

    static func updateRootVC() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            if UserDefaults.standard.bool(forKey: UserDefaultKey.loginStatus) {
                if UserDefaults.standard.bool(forKey: UserDefaultKey.isNotFirstTime) {
                    sceneDelegate.goToMain()
                } else {
                    sceneDelegate.goToOnboard()
                }
            } else {
                sceneDelegate.goToSignIn()
            }
        }
    }
}
