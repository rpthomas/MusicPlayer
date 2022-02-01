//
//  AppleMusicViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

import UIKit
import StoreKit

class AppleMusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AppleMusicCell {

    struct Storyboard {
        static let AppMusicCell = "AppMusicCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    var songsArray: [Song]?
    var searchTerm: String?
    var btnPrevious = UIButton()
    var btnNext = UIButton()
    var message = UILabel()
    static var nextPage: String = ""
    var parentView: AppleMusicChoiceViewController?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        btnPrevious.isEnabled = false
        btnPrevious.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        btnPrevious.setTitleColor(.black, for: .normal)

        AppleMusicAPI().getUserToken()


        setup()
        let group = DispatchGroup()
        


        group.notify(queue: .main) {
            SKCloudServiceController.requestAuthorization{ [self](status) in
                if status == .authorized {
                    
                    if UserDefaults.standard.object(forKey: "UserToken") == nil
                    {
                            group.enter()
                            
                            DispatchQueue.main.async {
                                
                                AppleMusicAPI().getUserToken()
                                group.leave()
                            }
                    }
                    
                    
                    AppleMusicAPI().searchAppleMusic(searchTerm){ (songs) in
                        
                        DispatchQueue.main.async {
                            songsArray = songs
                            print(songsArray?.count as Any)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    

   
    func setup()
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 40, width: screenWidth , height: 30))
        headerView.backgroundColor = .lightGray
            
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: screenWidth, height: 24))
        labelView.isUserInteractionEnabled = true
          //labelView.text = "My header view"
        
        let button = UIButton(frame: CGRect(x: 5, y: 0, width: 100, height: 20))
        button.backgroundColor = .darkGray
        button.setTitle("Back", for: .normal)
        
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .darkGray
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        button.setTitleColor(.yellow, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

        labelView.addSubview(button)
        
        btnPrevious = UIButton(frame: CGRect(x: 125, y: 0, width: 100, height: 20))
        btnPrevious.backgroundColor = .darkGray
        btnPrevious.setTitle("Prev. Page", for: .normal)
        
        btnPrevious.layer.masksToBounds = false
        btnPrevious.layer.cornerRadius = 5
        btnPrevious.layer.shadowColor = UIColor.black.cgColor
        btnPrevious.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnPrevious.layer.shadowOpacity = 0.5
        btnPrevious.layer.shadowRadius = 5
        btnPrevious.layer.borderColor = UIColor.black.cgColor
        btnPrevious.layer.borderWidth = 1
        btnPrevious.backgroundColor = .darkGray
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        btnPrevious.setTitleColor(.yellow, for: .normal)
        btnPrevious.isUserInteractionEnabled = true
        btnPrevious.addTarget(self, action: #selector(previousPageTap), for: .touchUpInside)

        labelView.addSubview(btnPrevious)
        
        btnNext = UIButton(frame: CGRect(x: 255, y: 0, width: 100, height: 20))
        btnNext.backgroundColor = .darkGray
        btnNext.setTitle("Next Page", for: .normal)
        
        btnNext.layer.masksToBounds = false
        btnNext.layer.cornerRadius = 5
        btnNext.layer.shadowColor = UIColor.black.cgColor
        btnNext.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnNext.layer.shadowOpacity = 0.5
        btnNext.layer.shadowRadius = 5
        btnNext.layer.borderColor = UIColor.black.cgColor
        btnNext.layer.borderWidth = 1
        btnNext.backgroundColor = .darkGray
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        btnNext.setTitleColor(.yellow, for: .normal)
        btnNext.isUserInteractionEnabled = true
        btnNext.addTarget(self, action: #selector(nextPageTap), for: .touchUpInside)

        labelView.addSubview(btnNext)
          
        headerView.addSubview(labelView)
        self.view.addSubview(headerView)
        
        message.text = "No Results Found"
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.textAlignment = .center

        self.view.addSubview(message)

        message.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

          
    }
    
    @objc func nextPageTap()
    {
        
        btnPrevious.isEnabled = true
        btnPrevious.backgroundColor = .darkGray

        let group = DispatchGroup()
                group.enter()

                DispatchQueue.main.async {
                    AppleMusicAPI().getUserToken()
                    group.leave()
                }


        group.notify(queue: .main) {
            SKCloudServiceController.requestAuthorization{ [self](status) in
                if status == .authorized {
                    AppleMusicAPI().searchAppleMusicNext(searchTerm, next: AppleMusicViewController.nextPage){ (songs) in

                        DispatchQueue.main.async {
                            songsArray = songs
                            print(songsArray?.count as Any)
                            self.tableView.reloadData()
                        }
                    }


                }
            }
        }

    }
    
    @objc func previousPageTap()
    {
        if AppleMusicViewController.nextPage != ""
        {
         let newPage : Int = Int(AppleMusicViewController.nextPage)! - 25
        
            if newPage <= 0
            {
                let group = DispatchGroup()
                        group.enter()
                        
                        DispatchQueue.main.async {
                            AppleMusicAPI().getUserToken()
                            group.leave()
                        }

                group.notify(queue: .main) {
                    SKCloudServiceController.requestAuthorization{ [self](status) in
                        if status == .authorized {
                            AppleMusicAPI().searchAppleMusic(searchTerm){ (songs) in
                                
                                DispatchQueue.main.async {
                                    songsArray = songs
                                    print(songsArray?.count as Any)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
            else
            {
            
                let group = DispatchGroup()
                        group.enter()

                        DispatchQueue.main.async {
                            AppleMusicAPI().getUserToken()
                            group.leave()
                        }


                group.notify(queue: .main) {
                    SKCloudServiceController.requestAuthorization{ [self](status) in
                        if status == .authorized {
                            AppleMusicAPI().searchAppleMusicNext(searchTerm, next: String(newPage)){ (songs) in

                                DispatchQueue.main.async {
                                    songsArray = songs
                                    print(songsArray?.count as Any)
                                    self.tableView.reloadData()
                                }
                            }


                        }
                    }
                }
            }
        }
        else
        {
            btnPrevious.isEnabled = false
            btnPrevious.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
            btnPrevious.setTitleColor(.black, for: .normal)

            let group = DispatchGroup()
                    group.enter()
                    
                    DispatchQueue.main.async {
                        AppleMusicAPI().getUserToken()
                        group.leave()
                    }


            group.notify(queue: .main) {
                SKCloudServiceController.requestAuthorization{ [self](status) in
                    if status == .authorized {
                        AppleMusicAPI().searchAppleMusic(searchTerm){ (songs) in
                            
                            DispatchQueue.main.async {
                                songsArray = songs
                                print(songsArray?.count as Any)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
      //  isMovingForward = false
        //self.parentView!.view.backgroundColor = UIColor(red: 100, green: 100, blue: 100, alpha: 1)
            
            //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.parentView!.view.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if songsArray != nil{
            self.message.isHidden = true
            return songsArray!.count
        }
        else
        {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.AppMusicCell, for: indexPath) as! AppleMusicTableViewCell
        
        cell.delegate = self
        cell.songCls = songsArray![indexPath.row]

        AppleMusicViewController.nextPage = cell.songCls.nextPage
        print(AppleMusicViewController.nextPage)
        cell.selectionStyle = .none
        
        if AppleMusicViewController.nextPage == ""
        {
            btnNext.isEnabled = false
            btnNext.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
            btnNext.setTitleColor(.black, for: .normal)

        }
        else
        {
            btnNext.isEnabled = true
            btnNext.backgroundColor = .darkGray
            btnNext.setTitleColor(.yellow, for: .normal)

            

        }
         //===========================
        
//        if self.prevPageVal == "" || self.prevPageVal == nil
//        {
//            btnPrevious.isEnabled = false
//            btnPrevious.backgroundColor = .lightGray
//            btnPrevious.setTitleColor(.black, for: .normal)
//
//
//        }
//        else
//        {
//            btnPrevious.isEnabled = true
//            btnPrevious.backgroundColor = .darkGray
//                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
//            btnPrevious.setTitleColor(.yellow, for: .normal)
//
//            btnNext.isEnabled = true
//            btnNext.backgroundColor = .darkGray
//            btnNext.setTitleColor(.yellow, for: .normal)
//
//        }
//
//        if self.nextPageVal == "" || self.nextPageVal == nil
//        {
//            btnNext.isEnabled = false
//            btnNext.backgroundColor = .lightGray
//            btnNext.setTitleColor(.black, for: .normal)
//
//        }
//        else
//        {
//            btnNext.isEnabled = true
//            btnNext.backgroundColor = .darkGray
//                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
//
//        }
//
//
        
        
   
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func didTap(_ cell: GooglePlaylistsTableViewCell) {
        
    }
}
