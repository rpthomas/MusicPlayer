//
//  YouTubeVideoPlayerViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/4/21.
//

import UIKit
import WebKit


class YouTubeVideoPlayerViewController: UIViewController, WKUIDelegate {

    var myPlayer: WKWebView!
    var videoId:String = ""
    var videlUrl:String = "https://www.youtube.com/embed/"
    var webView: WKWebView!

    
    @IBOutlet weak var btnClose: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        // Do any additional setup after loading the view.
        play()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    func setup()
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 40, width: screenWidth, height: 30))
        headerView.backgroundColor =  .lightGray
        //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 286, height: 24))
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
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

        labelView.addSubview(button)
        

        headerView.addSubview(labelView)
        self.view.addSubview(headerView)

    }
    func play()
    {
        let url: String = videlUrl + videoId + "?playsinline=1&controls:1"
        
        
        let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
                webView.uiDelegate = self
                view = webView
        
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width - 10


        myPlayer = WKWebView(frame: CGRect(x: 5, y: 50, width: width, height: 500), configuration: webConfiguration)
        self.view.addSubview(myPlayer)

        if let videoURL:URL = URL(string: url) {
             let request:URLRequest = URLRequest(url: videoURL)
             myPlayer.load(request)
        }

        //OR to show player control also, use this
        //if let videoURL:URL = URL(string: //"https://www.youtube.com/embed/9n1e1N0Sa9k?playsinline=1&controls:1") {
            
    }
    
    @objc @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
 

    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func endVideo()
    {
        
    }
}

