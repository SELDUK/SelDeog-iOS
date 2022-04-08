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
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func goToMain() {
        window?.rootViewController = BaseNavigationController(rootViewController: CalendarViewController())
        window?.makeKeyAndVisible()
      }
      
    func goToSignIn() {
        window?.rootViewController = StartSignInViewController()
        window?.makeKeyAndVisible()
    }
    
    func goToOnboard() {
        window?.rootViewController = BaseNavigationController(title: "MY CHARACTER", rootViewController: SelectShapeViewController())
        window?.makeKeyAndVisible()
    }


}

