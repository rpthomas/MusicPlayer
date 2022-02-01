//
//  AppDelegate.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import UIKit
import AuthenticationServices
import UserNotifications
import SpotifyLogin
//import PushNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate{
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//    }
    
    
    

    var window: UIWindow?
    //let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //self.pushNotifications.start(instanceId: "e9cb60b1-ee49-4750-bf56-ae83b84b438e")
          //  self.pushNotifications.registerForRemoteNotifications()
         //   try? self.pushNotifications.addDeviceInterest(interest: "debug-multimedia")
        // Initialize Google sign-in.
       // GIDSignIn.sharedInstance().delegate = self

        //GIDSignIn.sharedInstance().clientID = "906287499950-8ukqkus1p13u0064gmut5jkaiatljvsr.apps.googleusercontent.com"
        
        SpotifyLogin.shared.configure(clientID: "57acae2f4dbe4da49653fafe96c130e3", clientSecret: "48ca1dd3e1ab4df098cf5aaa5b9c09c3", redirectURL: URL(string: "https://www.spotify.com/us/home/")!)

        
        // Override point for customization after application launch.
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                DispatchQueue.main.async {
//                    self.window?.rootViewController?.showLoginViewController()
//                }
            break
            default:
                break
            }
        }
        
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 2.0))
        //registerForPushNotifications()
        
        //To remove bubble
        //application.applicationIconBadgeNumber = 0
        return true
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = SpotifyLogin.shared.applicationOpenURL(url) { (error) in }
        return handled
    }
   

//    func application(_ application: UIApplication,
//                         open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//            return GIDSignIn.sharedInstance().handle(url,
//                                                     sourceApplication: sourceApplication,
//                                                     annotation: annotation)
//        }
//
//        @available(iOS 9.0, *)
//        func application(_ app: UIApplication, open url: URL,
//                         options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//            let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
//            let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
//            return GIDSignIn.sharedInstance().handle(url,
//                                                     sourceApplication: sourceApplication,
//                                                     annotation: annotation)
//        }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func registerForPushNotifications() {
      //1
        UNUserNotificationCenter.current()
          .requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
            
          }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }

    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }

    
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //self.pushNotifications.handleNotification(userInfo: userInfo)
    }
    
    // MARK: Spotify Methods
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      print("connected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      print("player state changed")
    }}

