//
//  YouTubeNewLoginViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/25/21.
//

import UIKit

struct Config: Decodable {
    private enum CodingKeys: String, CodingKey {
        case CLIENT_ID, REVERSED_CLIENT_ID, PLIST_VERSION,BUNDLE_ID
    }

    let CLIENT_ID: String
    let REVERSED_CLIENT_ID: String
    let PLIST_VERSION: String
    let BUNDLE_ID: String
}

class YouTubeNewLoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        let config = parseConfig()
        print(config.CLIENT_ID)
        print(config.REVERSED_CLIENT_ID)
        print(config.PLIST_VERSION)
        print(config.BUNDLE_ID)

        GIDSignIn.sharedInstance().clientID = config.CLIENT_ID
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().scopes = ["profile", "email"]
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
    }
        

    
    
    func parseConfig() -> Config {
        let url = Bundle.main.url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Config.self, from: data)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email

            print(userId as Any)
            print(idToken as Any)
            print(fullName as Any)
            print(givenName as Any)
            print(familyName as Any)
            print(email as Any)

        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
    func setup()
    {
        let btnGoogle = UIButton(frame: CGRect(x: 40, y: 200, width: 300, height: 60))
        btnGoogle.setTitle("   Google Sign In   ", for: .normal)
        btnGoogle.setTitleColor(UIColor.black, for: .normal)
        btnGoogle.addTarget(self, action: #selector(self.signIn), for: .touchUpInside)
        
        btnGoogle.layer.masksToBounds = false
        btnGoogle.layer.cornerRadius = 5
        btnGoogle.layer.shadowColor = UIColor.black.cgColor
        btnGoogle.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnGoogle.layer.shadowOpacity = 0.5
        btnGoogle.layer.shadowRadius = 5
        btnGoogle.layer.borderColor = UIColor.black.cgColor
        btnGoogle.layer.borderWidth = 1
        btnGoogle.backgroundColor = UIColor.lightGray
        btnGoogle.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)

        btnGoogle.translatesAutoresizingMaskIntoConstraints = false


        self.view.addSubview(btnGoogle)
        
        btnGoogle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnGoogle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func signIn()
    {
        let config = parseConfig()
        print(config.CLIENT_ID)
        print(config.REVERSED_CLIENT_ID)
        print(config.PLIST_VERSION)
        print(config.BUNDLE_ID)

        GIDSignIn.sharedInstance().clientID = config.CLIENT_ID
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        GIDSignIn.sharedInstance().scopes = ["profile", "email"]
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
   
}
