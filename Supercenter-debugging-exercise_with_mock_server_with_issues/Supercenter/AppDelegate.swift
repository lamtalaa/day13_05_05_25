//
//  AppDelegate.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/10/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: ProductListViewController())
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
