//
//  SpotifyLoginViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 7/12/21.
//

import UIKit
import WebKit
//import SpotifyLogin

class SpotifyLoginViewController: UIViewController {

    var isSession:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        SpotifyLogin.shared.getAccessToken { [self] (accessToken, error) in
            if error != nil {
                // User is not logged in, show log in flow.
                
                SpotifyLoginPresenter.login(from: self, scopes: [.streaming, .userLibraryRead])

                
                
//                let button = SpotifyLoginButton(viewController: self, scopes: [.streaming, .userLibraryRead])
//                button.backgroundColor = UIColor.blue
//                self.view.addSubview(button)
            }
            else
            {
                isSession = true
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
