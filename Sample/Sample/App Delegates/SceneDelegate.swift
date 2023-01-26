//
//  SceneDelegate.swift
//  Sample
//
//  Created by William on 2023/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var navigationController: UINavigationController = {
        let viewController = UINavigationController(rootViewController: self.createHomeViewController())
        viewController.navigationBar.prefersLargeTitles = true
        
        return viewController
    } ()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = .init(windowScene: windowScene)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: HomeViewControllerDelegate {
    func userDidSelectRowAt(category: Category) {
        if category == .grid_layout {
            self.navigationController.pushViewController(createGridLayoutViewController(), animated: true)
            return
        }
    }
}

private extension SceneDelegate {
    func createHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        viewController.delegate = self
        
        return viewController
    }
    
    func createGridLayoutViewController() -> GridLayoutViewController {
        let viewController = GridLayoutViewController()
        
        return viewController
    }
}
