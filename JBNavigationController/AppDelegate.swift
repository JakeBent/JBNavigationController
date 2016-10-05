//
//  AppDelegate.swift
//  JBNavigationController
//
//  Created by Jacob Benton on 8/29/16.
//  Copyright © 2016 jakebent. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let navController = JBNavigationController(rootViewController: ViewController())
        navController.navigationDirection = .Down

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()

        return true
    }
}