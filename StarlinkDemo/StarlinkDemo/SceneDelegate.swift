//
//  SceneDelegate.swift
//  StarlinkDemo
//
//  Created on 2025-09-05.
//  Copyright © 2025 Starlink Demo. All rights reserved.
//

import UIKit
import Starlink

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create window
        window = UIWindow(windowScene: windowScene)
        
        // Set StarlinkWebViewController as root view controller
        let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
        window?.rootViewController = rootViewController
        
        // Make window visible
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Stop local server when scene disconnects
        StarlinkCore.shared.stopLocalServer()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Optionally stop the local server to save resources
        StarlinkCore.shared.stopLocalServer()
    }
}
