//
//  WebViewAppDelegate.swift
//  StarlinkDemo
//
//  Created on 2025-09-05.
//  Copyright © 2025 Starlink Demo. All rights reserved.
//

import UIKit
import Starlink

/// Example AppDelegate for a webview-based app where StarlinkWebViewController is the root view controller
class WebViewAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Starlink framework
        let config = StarlinkConfiguration(
            apiKey: "your-api-key",
            environment: .development,
            enableLogging: true
        )
        StarlinkCore.shared.initialize(with: config)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }
}

/// Example SceneDelegate for a webview-based app
class WebViewSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create window
        window = UIWindow(windowScene: windowScene)
        
        // Set WebView controller as root view controller
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
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Optionally stop the local server to save resources
        StarlinkCore.shared.stopLocalServer()
    }
}
