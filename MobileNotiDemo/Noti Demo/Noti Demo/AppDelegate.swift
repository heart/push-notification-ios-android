//
//  AppDelegate.swift
//  Noti Demo
//
//  Created by narongrit kanhanoi on 15/11/2561 BE.
//  Copyright © 2561 narongrit kanhanoi. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
   
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        
        let info:[String: String] = ["token": token]
        
        NotificationCenter.default.post(name:.gotPushKey, object:nil, userInfo:info)
    }
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        let info:[String: String] = ["error": error.localizedDescription]
        NotificationCenter.default.post(name:.remotePushRegisterError, object:nil, userInfo:info)
        
    }

}


extension Notification.Name {
    static let gotPushKey = Notification.Name("push_key")
    static let remotePushRegisterError = Notification.Name("remote_push_error")
    
}
