//
//  AppDelegate.swift
//  VietEduApp
//
//  Created by Thien Truong on 8/17/23.
//

import UIKit
import UIKit
import FirebaseMessaging
import Firebase
import IQKeyboardManagerSwift
import FirebaseAuth
import FirebaseDynamicLinks
import GooglePlaces
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegae not found. This could never happen!")
        }
        return delegate
    }
    var window: UIWindow?
    var fcmToken: String?
    var tabbar: BaseTabbarViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        setupRootView()
        window?.makeKeyAndVisible()
        
        GMSPlacesClient.provideAPIKey(GG_API_KEY)
        return true
    }
    
    func setupRootView() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            
            Utils.shared.gotoLogin()
//            Utils.shared.gotoHome()
        }else{
            print("currentUser: \(FirebaseAuth.Auth.auth().currentUser)")
            Utils.shared.gotoHome()
        }
    }



}
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //setup device
        print(#function)
        #if DEBUG
        Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
        #else
        Auth.auth().setAPNSToken(deviceToken, type: .prod)
        #endif
        Messaging.messaging().apnsToken = deviceToken
        print("===> didRegisterForRemoteNotificationsWithDeviceToken: \(Messaging.messaging().fcmToken)\n deviceToken: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushNotificationHandler.shared.didReceiveRemoteNotification(userInfo: userInfo, application: application)
    }
    
    // Handle Notifications While Your App Runs in the Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Change this to your preferred presentation option
        // Play a sound.
        //  completionHandler(UNNotificationPresentationOptions.sound)
        completionHandler([.alert, .badge, .sound])
    }
    
    // While App is inactive  in background
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userinfoData = response.notification.request.content.userInfo
        // While App is inactive  in background
        print(userinfoData)
        debugPrint("===> didReceive response: UNNotificationResponse: \(userinfoData)")
        completionHandler()
    }
}
extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("===> Firebase registration token: \(fcmToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("===>didReceiveRegistrationToken fcm token: \(fcmToken)")
        self.fcmToken = fcmToken
    }
 
}


func appDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
