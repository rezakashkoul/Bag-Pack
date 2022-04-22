//
//  AppDelegate.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 20/Bahman/1400 .
//

import UIKit
import netfox
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NFX.sharedInstance().start()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = appGlobalTintColor
//        IQKeyboardManager.shared.keyboardDistanceFromTextField = 0
        
        
        return true
    }
}

