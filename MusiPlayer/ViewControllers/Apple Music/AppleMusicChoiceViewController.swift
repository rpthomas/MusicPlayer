//
//  AppleMusicChoiceViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/15/21.
//

import UIKit
import AuthenticationServices
import CloudKit
import StoreKit


//import StoreKit


class AppleMusicChoiceViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    
    @IBOutlet weak var btnBrowse: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtNotice: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        setup()
        
    
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        notificationCenter.addObserver(self, selector:#selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        
        performExistingAccountSetupFlows()

        checkForAppleMusic()
        
//        let group = DispatchGroup()
//
//        group.notify(queue: .main) {
//            SKCloudServiceController.requestAuthorization{ (status) in
//                if status == .authorized {
//                    if UserDefaults.standard.object(forKey: "UserToken") == nil
//                    {
//                            group.enter()
//
//                            DispatchQueue.main.async {
//                                AppleMusicAPI().getUserToken()
//                                group.leave()
//                            }
//                    }
//
//
//                }
//            }
//        }
    }
    func checkForAppleMusic()
    {
        
        let serviceController = SKCloudServiceController()
        serviceController.requestCapabilities { (capability:SKCloudServiceCapability, err:Error?) in
            guard err == nil else {
                print("error in capability check is \(err!)")
                return
            }
                    
            if capability.contains(SKCloudServiceCapability.musicCatalogPlayback) {
                self.txtNotice.text = "You have an Apple Music subscription and can play music from apple music API."
                self.btnBrowse.layer.backgroundColor = UIColor.darkGray.cgColor
                self.btnBrowse.isEnabled = true
            }

            if capability.contains(SKCloudServiceCapability.addToCloudMusicLibrary) {
                self.txtNotice.text = "You have an Apple Music subscription, can play music from the API, and can also add to your music library."
                
                self.btnBrowse.layer.backgroundColor = UIColor.darkGray.cgColor
                self.btnBrowse.isEnabled = true
            }

            if capability.contains(SKCloudServiceCapability.musicCatalogSubscriptionEligible) {
                print("user does not have subscription")
                self.txtNotice.text = "You do not have a Apple Music Subscription"
                self.btnBrowse.layer.backgroundColor = UIColor.lightGray.cgColor
                self.btnBrowse.isEnabled = false
            }
        }
    }
//        SKCloudServiceController().requestCapabilities { (capability:SKCloudServiceCapability, err:Error?) in
//
//            guard err == nil else {
//                print("error in capability check is \(err!)")
//                return
//            }
//
//            if capability.contains(SKCloudServiceCapability.musicCatalogPlayback) {
//                print("user has Apple Music subscription")
//                MPMusicPlayerController.systemMusicPlayer.setQueue(with: ["1108845248"])
//                systemMusicPlayer.prepareToPlay { (error) in
//                    if error != nil && error!.localizedDescription == "The operation couldn’t be completed. (MPCPlayerRequestErrorDomain error 1.)" {
//                        //It would appear that the user does not have the Apple Music App installed
//                    }
//                }
//            }
//
//            if capability.contains(SKCloudServiceCapability.musicCatalogSubscriptionEligible) {
//                print("user does not have subscription")
//            }
//
//        }
//    }
    
    @objc func appMovedToBackground() {
        //checkForAppleMusic()
    }
    
    @objc func appMovedToForeground() {
     print("App moved to foreground!")
        //checkForAppleMusic()
//        if isICloudContainerAvailable()
//        {
//            txtNotice.text = "\n\nApple Music Catalog is Available"
//            txtNotice.textAlignment = .center
//
//        }
//        else{
//            txtNotice.text = "An Apple Music account is required to perform searches of the Music Catlogue.\n\nSign in to Apple Music before performing searches."
//        }

     }

    
    override func viewWillAppear(_ animated: Bool) {
        //self.view.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
            
            
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        checkForAppleMusic()
//        if isICloudContainerAvailable()
//        {
//            txtNotice.text = "\n\nApple Music Catalog is Available"
//            txtNotice.textAlignment = .center
//            checkForAppleMusic()
//        }
//        else{
//            txtNotice.text = "An Apple Music account is required to perform searches of the Music Catlogue.\n\nSign in to Apple Music before performing searches."
//        }
    }

    func setup()
    {
        btnBrowse.layer.masksToBounds = false
        btnBrowse.layer.cornerRadius = 5
        btnBrowse.layer.shadowColor = UIColor.black.cgColor
        btnBrowse.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnBrowse.layer.shadowOpacity = 0.5
        btnBrowse.layer.shadowRadius = 5
        btnBrowse.layer.borderColor = UIColor.black.cgColor
        btnBrowse.layer.borderWidth = 1
        
        txtSearch.layer.masksToBounds = false
        txtSearch.layer.shadowRadius = 5.0
        txtSearch.layer.shadowColor = UIColor.black.cgColor
        txtSearch.layer.shadowOffset = CGSize(width: 10.0,height:  10.0)
        txtSearch.layer.shadowOpacity = 0.5
        txtSearch.backgroundColor = .white
        txtSearch.layer.borderColor = UIColor.black.cgColor
        txtSearch.layer.borderWidth = 1
        txtSearch.layer.cornerRadius = 5
        
        txtNotice.layer.masksToBounds = false
        txtNotice.layer.cornerRadius = 5
        txtNotice.layer.shadowColor = UIColor.black.cgColor
        txtNotice.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        txtNotice.layer.shadowOpacity = 0.5
        txtNotice.layer.shadowRadius = 5
        txtNotice.layer.borderColor = UIColor.black.cgColor
        txtNotice.layer.borderWidth = 1
        txtNotice.layer.backgroundColor = UIColor.white.cgColor


 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
         if segue.identifier == "segAppMusic" {
            if let appleMusicController = segue.destination as? AppleMusicViewController {
                appleMusicController.modalPresentationStyle = .fullScreen
                appleMusicController.searchTerm = txtSearch.text!
                appleMusicController.parentView = self
                self.view.backgroundColor = .lightGray

            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !isValidParams()
        {
            return false
        }
        
        return true
    }
    
    func isValidParams() -> Bool{
        if txtSearch.text!.count < 3
        {
            missingTermAlert()
            return false
        }
        else if txtSearch.text!.containsSpecialCharacters(string: txtSearch.text!){
            invalidCharacterAlert()
            return false
        }
        else
        {
            return true
        }
    }
    
    func invalidCharacterAlert()
    {
        let alertController = UIAlertController(title: "Invalid Character", message:
                "Special characters and punctuation cannot be used!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }

    func missingTermAlert()
    {
        let alertController = UIAlertController(title: "Missing Search Term", message:
                "Please enter what you are searching for!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }

    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        handleAuthorizationAppleIDButtonPress()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!

    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    func isICloudContainerAvailable()->Bool {
            print(#function)
        CKContainer.default().accountStatus { (accountStatus, error) in

                if accountStatus == .available {
                    return
                }

                ///
                // Checking account availability
                // Silently return if everything goes well, or do a second check 200ms after the first failure
                //

                DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {

                        guard error != nil, accountStatus != CKAccountStatus.available else {return}

                            print("iCloud account is not available! Be sure you have signed in iCloud on this device!")
                        }
                    }


            if FileManager.default.ubiquityIdentityToken != nil {
                //print("User logged in")
                return true
            }
            else {
                //print("User is not logged in")
                return false
            }

        }

}


