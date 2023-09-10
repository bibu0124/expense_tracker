//
//  PushNotificationHandler.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import Foundation
import UserNotifications
import Firebase
import SwiftMessages

enum NotificationKey : String {
    case kDidReceiveNotification = "kDidReceiveNotification"
}

enum PushNotificationKeys : String {
    case request_relationship = "request_relationship"
    case didUpdateCart = "didUpdateCart"
}

final class PushNotificationHandler {
    
    static var shared = PushNotificationHandler()
    
    func didReceiveRemoteNotification(userInfo: [AnyHashable : Any], application: UIApplication) {
        
        if let dict_: NSDictionary = userInfo as [AnyHashable: Any]? as NSDictionary? {
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: dict_, options: .prettyPrinted) else {
                return
            }
            guard let decoded = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                return
            }
            
            guard let dict = decoded as? [String : Any] else {
                print("failed")
                return
            }
            print(dict)
            NotificationCenter.default.post(name: NSNotification.Name(NotificationKey.kDidReceiveNotification.rawValue), object: nil, userInfo: nil)
            do {
                guard let model = dict.toCodableObject() as PushNotificationModel? else {return}
                
                if application.applicationState == .active  {
                    self.handleNotification(model, isActive: true)
                    print("active app")
                }
                else if application.applicationState == .inactive {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.handleNotification(model, isActive: false)
                    }
                }
                else if application.applicationState == .background {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.handleNotification(model, isActive: false)
                    }
                }
                
            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
    
    
    func touchedOnNotificationBanner(userInfo: [AnyHashable : Any]) {
        
        //        let VC = STORYBOARD_SETTING.instantiateViewController(withIdentifier: ProfileViewController.className) as! ProfileViewController
        //
        //        let baseVC = UIViewController.getTopViewController()
        //
        //        baseVC?.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func showPopUp(_ model: PushNotificationModel) {
        //       let alert = CommonAlert.instanceFromNib()
        //        alert.show(title: model.aps?.alert?.title ?? "", desc: model.aps?.alert?.body ?? "") {
        //
        //        }
    }
    
    func handleNotification(_ model: PushNotificationModel, isActive: Bool) {
        print(isActive)
    
    }

    
    func setupNotificationFCM(_ application: UIApplication) {
        FirebaseApp.configure()
        

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    func initFCMToken(_ application: UIApplication, tokenData: Data) -> String {
        let deviceToken:String = tokenData.reduce("", {$0 + String(format: "%02X", $1)})
        
        return deviceToken
    }
    
    func refeshFCMToken() {
        
    }
    
}

