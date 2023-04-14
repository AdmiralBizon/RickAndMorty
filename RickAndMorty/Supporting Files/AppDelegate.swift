//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import UIKit
import NetworkActivityMonitor
import DebugScreen

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityMonitor.shared.loggingType = .sessionProxy
        DebugScreenConfiguration.shared.actionsProvider = DebugScreenActionsProvider()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
