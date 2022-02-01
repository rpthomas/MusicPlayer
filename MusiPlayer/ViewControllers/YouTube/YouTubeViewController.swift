//
//  YouTubeViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/21/21.
//

import UIKit

class YouTubeViewController: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var youTubeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        //playerView.load(withVideoId: "ap90npnxZzs")
        
        youTubeImageView.image = UIImage(named: "pexels-asad-photo-maldives-1450360.jpg")!
                   
        
        //playerView.loadVideo(byURL: <#T##String#>, startSeconds: <#T##Float#>, endSeconds: <#T##Float#>, suggestedQuality: <#T##WKYTPlaybackQuality#>)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    //https://www.youtube.com/watch?v=ap90npnxZzs
func setup()
{
   
        btnSearch.layer.masksToBounds = false
        btnSearch.layer.cornerRadius = 5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.layer.shadowRadius = 5
        btnSearch.layer.borderColor = UIColor.black.cgColor
        btnSearch.layer.borderWidth = 1
        
        btnLogin.layer.masksToBounds = false
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnLogin.layer.shadowOpacity = 0.5
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.borderColor = UIColor.black.cgColor
        btnLogin.layer.borderWidth = 1
    
    
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
