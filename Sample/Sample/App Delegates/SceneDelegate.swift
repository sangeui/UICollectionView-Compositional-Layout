//
//  SceneDelegate.swift
//  Sample
//
//  Created by William on 2023/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = .init(windowScene: windowScene)
        self.window?.rootViewController = GridLayoutViewController()
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: HomeViewControllerDelegate {
    func userDidSelectRowAt(category: Category) {
        
    }
}

private extension SceneDelegate {
    func createHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        viewController.delegate = self
        
        return viewController
    }
}
