//
//  YouTubePlayListItemsViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/2/21.
//

import UIKit

class YouTubePlayListItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GooglePlaylistsDetail, UITextFieldDelegate {
   
//    var myPlayer: WKWebView!
    

    
    struct Storyboard {
        static let GoogPListDetailsCell = "GoogPListDetailsCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chanTitle: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var btnGoTo: UIButton!
    @IBOutlet weak var lblPrev: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    
    var btnPrevious = UIButton()
    var btnNext = UIButton()
    
    var googleClient = GoogleClient()
    var plist: [PlaylistsGoogle]?
    var playListID:String = ""
    var message = UILabel()
    var isMovingForward = false
    var prevPageVal: String? = ""
    var nextPageVal :String? = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        setup()
        fetchPlayListItems(playlistId: playListID)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        isMovingForward = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)

    }
   
    override func viewWillDisappear(_ animated: Bool) {
        if !isMovingForward
        {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func fetchPlayListItems(playlistId: String)
    {
        googleClient.fetchPlayListItems(byPlayListlId: playlistId) { [self] (plist) in

            DispatchQueue.main.async{
                self.plist = plist
                print(self.plist as Any)
                self.tableView.reloadData()
            }
            
        }
        //tableView.reloadData()

    }
    
    func setup()
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 40, width: screenWidth , height: 30))
        headerView.backgroundColor =  .lightGray
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
        button.backgroundColor =  .darkGray
        //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        button.setTitleColor(.yellow, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

        labelView.addSubview(button)
        
        btnPrevious = UIButton(frame: CGRect(x: 125, y: 0, width: 100, height: 20))
        btnPrevious.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        btnPrevious.setTitle("Prev. Page", for: .normal)
        
        btnPrevious.layer.masksToBounds = false
        btnPrevious.layer.cornerRadius = 5
        btnPrevious.layer.shadowColor = UIColor.black.cgColor
        btnPrevious.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnPrevious.layer.shadowOpacity = 0.5
        btnPrevious.layer.shadowRadius = 5
        btnPrevious.layer.borderColor = UIColor.black.cgColor
        btnPrevious.layer.borderWidth = 1
        btnPrevious.backgroundColor =  .darkGray
        //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        btnPrevious.setTitleColor(.yellow, for: .normal)
        btnPrevious.isUserInteractionEnabled = true
        btnPrevious.addTarget(self, action: #selector(previousPageTap), for: .touchUpInside)

        labelView.addSubview(btnPrevious)
        
        btnNext = UIButton(frame: CGRect(x: 255, y: 0, width: 100, height: 20))
        btnNext.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        btnNext.setTitle("Next Page", for: .normal)
        
        btnNext.layer.masksToBounds = false
        btnNext.layer.cornerRadius = 5
        btnNext.layer.shadowColor = UIColor.black.cgColor
        btnNext.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnNext.layer.shadowOpacity = 0.5
        btnNext.layer.shadowRadius = 5
        btnNext.layer.borderColor = UIColor.black.cgColor
        btnNext.layer.borderWidth = 1
        btnNext.backgroundColor =  .darkGray
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
    
    
    @objc @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        isMovingForward = false
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func nextPageTap()
    {
        if nextPageVal != nil && nextPageVal != ""
        {

            googleClient.fetchPlayListItemsNext(byPlayListlId: playListID, withNextPage: nextPageVal!) { [self] (plist) in

                DispatchQueue.main.async{
                    self.plist = plist
                    print(self.plist as Any)
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func previousPageTap()
    {
        if prevPageVal != nil && prevPageVal != ""
        {
            googleClient.fetchPlayListItemsNext(byPlayListlId: playListID, withNextPage: prevPageVal!) { [self] (plist) in

                DispatchQueue.main.async{
                    self.plist = plist
                    print(self.plist as Any)
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if plist?.count != nil{
            self.message.isHidden = true
            return plist!.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.GoogPListDetailsCell, for: indexPath) as! GooglePlaylistsDetailCell
        
        cell.delegate = self
        cell.playList = plist?[indexPath.row]
        cell.selectionStyle = .none
        self.prevPageVal = cell.prevPage.text
        self.nextPageVal = cell.nextPage.text
        
        if self.prevPageVal == "" || self.prevPageVal == nil
        {
            btnPrevious.isEnabled = false
            btnPrevious.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
            btnPrevious.setTitleColor(.black, for: .normal)

        }
        else
        {
            btnPrevious.isEnabled = true
            btnPrevious.backgroundColor = .darkGray
            btnPrevious.setTitleColor(.yellow, for: .normal)

                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        }
        
        if self.nextPageVal == "" || self.nextPageVal == nil
        {
            btnNext.isEnabled = false
            btnNext.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        }
        else
        {
            btnNext.isEnabled = true
            btnNext.backgroundColor = .darkGray
                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)

        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func didTap(_ cell: GooglePlaylistsDetailCell) {
        
        isMovingForward = true
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let vc : YouTubeVideoPlayerViewController = storyboard.instantiateViewController(withIdentifier: "player") as! YouTubeVideoPlayerViewController

        vc.videoId = cell.videoId.text!
        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(vc, animated: true, completion: nil)
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "segYouTubeItems" {
         // perform custom segue operation.
      }
   }
   
//    var myPlayer: WKWebView!
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            let webConfiguration = WKWebViewConfiguration()
//            webConfiguration.allowsInlineMediaPlayback = true
//            webConfiguration.mediaTypesRequiringUserActionForPlayback = []
//
//            myPlayer = WKWebView(frame: CGRect(x: 0, y: 0, width: 375, height: 300), configuration: webConfiguration)
//            self.view.addSubview(myPlayer)
//
//            if let videoURL:URL = URL(string: "https://www.youtube.com/embed/9n1e1N0Sa9k?playsinline=1") {
//                 let request:URLRequest = URLRequest(url: videoURL)
//                 myPlayer.load(request)
//            }
//
//            //OR to show player control also, use this
//            /*if let videoURL:URL = URL(string: "https://www.youtube.com/embed/9n1e1N0Sa9k?playsinline=1&controls:1") {
//
}
