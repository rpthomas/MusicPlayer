//
//  SpotifyViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 7/11/21.
//

import UIKit

class SpotifyViewController: UIViewController {

    let SpotifyClientID = "57acae2f4dbe4da49653fafe96c130e3"
    let SpotifyRedirectURL = URL(string: "Jedisware-Musi-Player://spotify-login-callback")!

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.playURI = ""
        self.connect()
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
      let parameters = appRemote.authorizationParameters(from: url);

            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
                appRemote.connectionParameters.accessToken = access_token
                self.accessToken = access_token
            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
                // Show the error
            }
      return true
    }


    func connect() {
      self.appRemote.authorizeAndPlayURI(self.playURI)
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      // Connection was successful, you can begin issuing commands
      self.appRemote.playerAPI?.delegate = self
      self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
        if let error = error {
          debugPrint(error.localizedDescription)
        }
      })
    }

    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      debugPrint("Track name: %@", playerState.track.name)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
      if self.appRemote.isConnected {
        self.appRemote.disconnect()
      }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
      if let _ = self.appRemote.connectionParameters.accessToken {
        self.appRemote.connect()
      }
    }
}
