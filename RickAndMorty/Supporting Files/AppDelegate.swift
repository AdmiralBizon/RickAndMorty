//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import UIKit
import DebugScreen
import netfox
import NetShears

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNetFox()
        configureNetShears()
        DebugScreenConfiguration.shared.actionsProvider = DebugScreenActionsProvider()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}


// MARK: - Private Methods

private extension AppDelegate {

    func configureNetFox() {
        NFX.sharedInstance().setGesture(.custom) // disable open by shake device
        NFX.sharedInstance().start()
    }

    func configureNetShears() {
        NetShears.shared.startLogger()
    }

}
