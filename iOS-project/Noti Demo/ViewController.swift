//
//  ViewController.swift
//  Noti Demo
//
//  Created by narongrit kanhanoi on 15/11/2561 BE.
//  Copyright © 2561 narongrit kanhanoi. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var tokenText: UITextView!
    @IBOutlet weak var copyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotiToken), name:.gotPushKey , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotiError), name:.remotePushRegisterError , object: nil)
        
        registerForPushNotifications()
    }
    
    @objc func onNotiToken(_ notification: Notification){
        guard let token:String = notification.userInfo?["token"] as? String else {
            return
        }
        print("Push Token = \(token)")
        self.tokenText.text = token
    }
    
    @objc func onNotiError(_ notification: Notification){
        guard let error:String = notification.userInfo?["error"] as? String else {
            return
        }
        self.tokenText.text = error
    }
    
    @IBAction func clickCopy(_ sender: Any) {
        self.copyButton.setTitle("Copied!", for: .normal)
        UIPasteboard.general.string = self.tokenText.text
    }
    
    
    
}

extension ViewController:UNUserNotificationCenterDelegate{
    
    public func print2(_ items: Any..., separator: String = " ", terminator: String = "\n") {
       
        let output = items.map { "*\($0)" }.joined()
        Swift.print(output, terminator: terminator)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound (systemSoundID)
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print2("Action = \(response.actionIdentifier)")
        
        if response.actionIdentifier == "like" {
            print2("Handle like action identifier")
        } else if response.actionIdentifier == "save" {
            print2("Handle save action identifier")
        } else {
            print2("No custom action identifiers chosen")
        }
        
        // Make sure completionHandler method is at the bottom of this func
        completionHandler()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            
            self.getNotificationSettings()  
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    self.labelStatus.text = "Push notification : ENABLED"
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.labelStatus.text = "Push notification : DISABLED"
                }
            }
        }
    }
    
    
}
