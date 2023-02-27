//
//  AppDelegate.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.backgroundColor = .systemBackground
        let VC = HomeViewController()
        let navigationController = UINavigationController(rootViewController: VC)
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
        
        return true
    }
}

