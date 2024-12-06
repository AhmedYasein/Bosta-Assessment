//
//  SceneDelegate.swift
//  Bosta Assessment
//
//  Created by Ahmed Yasein on 03/12/2024.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Create an instance of ProfileViewController
        let profileVC = ProfileViewController()
        
        // Embed it in a navigation controller if necessary
        let navigationController = UINavigationController(rootViewController: profileVC)
        
        // Set navigation controller as the root view controller
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
