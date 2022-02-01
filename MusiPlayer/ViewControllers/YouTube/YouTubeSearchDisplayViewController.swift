//
//  YouTubeSearchDisplayViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/25/21.
//

import UIKit

class YouTubeSearchDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GooglePlaylistsCell, UITextFieldDelegate{

    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var btnPrevious: UIButton!
    //@IBOutlet weak var btnNext: UIButton!

    var btnPrevious = UIButton()
    var btnNext = UIButton()

    var googleClient = GoogleClient()
    var chan: [ChannelListGoogle]?
    var c: String?
    var plist: [PlaylistsGoogle]?
    var playListId: String = ""
    var message = UILabel()
    var isMovingForward = false
    var prevPageVal: String? = ""
    var nextPageVal :String? = ""
    var parentView: YouTubeSearchViewController?


    struct Storyboard {
        static let GoogPListCell = "GoogPListCell"
        //static let bookCell = "BookCell"
    }
    
    
    
    var channelParam: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        setup()

        googleClient.fetchChannelsList(forUsername: channelParam) { [self] (cha) in
             
            for (key, value) in cha! {
                print(key)
                print(value)
                if key == "items"
                {
                    for items in value as! [Any]{
                        print(type(of: items))
                        print(items)
                        if let dictionary = items as? [String:Any]{
                            print(dictionary["id"] as! String)
                            self.c = (dictionary["id"] as! String)
                            break
                        }
                        break
                    }
                }
                print(type(of: value))
            }
            
            
            
            print(self.c as Any)
            if self.c != nil{
                googleClient.fetchPlayList(bychannelId: self.c!) { (plist) in
                    self.plist = plist
                            
                    print(self.plist as Any)
                    self.tableView.reloadData()
                    }
            }
            
            
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        isMovingForward = false

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
        button.backgroundColor = .blue
        button.setTitle("Back", for: .normal)
        
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .brown
        button.setTitleColor(.yellow, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

        labelView.addSubview(button)
        
        btnPrevious = UIButton(frame: CGRect(x: 125, y: 0, width: 100, height: 20))
        btnPrevious.backgroundColor = .blue
        btnPrevious.setTitle("Prev. Page", for: .normal)
        
        btnPrevious.layer.masksToBounds = false
        btnPrevious.layer.cornerRadius = 5
        btnPrevious.layer.shadowColor = UIColor.black.cgColor
        btnPrevious.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnPrevious.layer.shadowOpacity = 0.5
        btnPrevious.layer.shadowRadius = 5
        btnPrevious.layer.borderColor = UIColor.black.cgColor
        btnPrevious.layer.borderWidth = 1
        
        btnPrevious.isEnabled = false
        btnPrevious.backgroundColor = .lightGray
        btnPrevious.setTitleColor(.black, for: .normal)
        
        btnPrevious.addTarget(self, action: #selector(previousPageTap), for: .touchUpInside)
        
        labelView.addSubview(btnPrevious)
        
        btnNext = UIButton(frame: CGRect(x: 255, y: 0, width: 100, height: 20))
        btnNext.backgroundColor = .blue
        btnNext.setTitle("Next Page", for: .normal)
        
        btnNext.layer.masksToBounds = false
        btnNext.layer.cornerRadius = 5
        btnNext.layer.shadowColor = UIColor.black.cgColor
        btnNext.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        btnNext.layer.shadowOpacity = 0.5
        btnNext.layer.shadowRadius = 5
        btnNext.layer.borderColor = UIColor.black.cgColor
        btnNext.layer.borderWidth = 1
        btnNext.backgroundColor =  .brown
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
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if !isMovingForward
        {
            //self.parentView!.view.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func prevPageTap()
    {
        
    }

    @objc func nextPageTap()
    {
        if nextPageVal != nil && nextPageVal != ""
        {
            print(self.c as Any)
            print(nextPageVal as Any)

            googleClient.fetchPlayNextList(bychannelId: self.c!, withNextPage: nextPageVal!) { (plist) in
                self.plist = plist
                        
                print(self.plist as Any)
                self.tableView.reloadData()

                }
        }
    }
    
    @objc func previousPageTap()
    {
        if prevPageVal != nil && prevPageVal != ""
        {
            print(self.c as Any)
            print(nextPageVal as Any)

            googleClient.fetchPlayNextList(bychannelId: self.c!, withNextPage: prevPageVal!) { (plist) in
                self.plist = plist
                        
                print(self.plist as Any)
                self.tableView.reloadData()
                }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let playListItems = segue.destination as!
            YouTubePlayListItemsViewController
        
        playListItems.playListID = playListId
        print(playListId)
        playListItems.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    }
    
    
    func didTap(_ cell: GooglePlaylistsTableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        let cell = tableView.cellForRow(at: indexPath!) as! GooglePlaylistsTableViewCell
        playListId = cell.lblID.text!
        isMovingForward = true
        print(playListId)
        
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.GoogPListCell, for: indexPath) as! GooglePlaylistsTableViewCell
        
        cell.delegate = self
        cell.playList = plist?[indexPath.row]
        print(plist as Any)
        cell.selectionStyle = .none
        self.prevPageVal = cell.prevPage.text
        self.nextPageVal = cell.nextPage.text
        
        print(self.prevPageVal as Any)
        print(self.nextPageVal as Any)

        if self.prevPageVal == "" || self.prevPageVal == nil
        {
            btnPrevious.isEnabled = false
            btnPrevious.backgroundColor = .lightGray
            btnPrevious.setTitleColor(.black, for: .normal)


        }
        else
        {
            btnPrevious.isEnabled = true
            btnPrevious.backgroundColor = .darkGray
                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
            btnPrevious.setTitleColor(.yellow, for: .normal)
            
            btnNext.isEnabled = true
            btnNext.backgroundColor = .darkGray
            btnNext.setTitleColor(.yellow, for: .normal)

        }
        
        if self.nextPageVal == "" || self.nextPageVal == nil
        {
            btnNext.isEnabled = false
            btnNext.backgroundColor = .lightGray
            btnNext.setTitleColor(.black, for: .normal)

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
}
