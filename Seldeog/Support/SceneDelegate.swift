//
//  SceneDelegate.swift
//  Seldeog
//
//  Created by 권준상 on 2022/02/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

//        UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
        var startViewController: UINavigationController
        let startModeString = UserDefaults.standard.startMode
        var startMode = StartMode(rawValue: startModeString) ?? .auth
        
        if isAutoLogin() {
            if isNotFirstTime() {
                startMode = .main
            } else {
                startMode = .onBoarding
            }
        } else {
            startMode = .auth
        }
        
        switch startMode {
            case .onBoarding:
                startViewController = UINavigationController(rootViewController: SelectShapeViewController())
            case .auth:
                startViewController = UINavigationController(rootViewController: StartSignInViewController())
            case .main:
                startViewController = UINavigationController(rootViewController: MainViewController())
        }
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    private func isAutoLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.isAutoLogin)
    }
    
    private func isNotFirstTime() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.isNotFirstTime)
    }


}

