//
//  AppDelegate.swift
//  Flash Chat
//
//  Created by Abdullah Alhaider on 12/14/17.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        FirebaseApp.configure()
        return true
    }

    
}
