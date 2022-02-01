//
//  ModalImageViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/9/21.
//

import UIKit

class ModalImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.clear
        //view.isOpaque = false
        // Do any additional setup after loading the view.
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
        btnDismiss.layer.masksToBounds = false
        btnDismiss.layer.cornerRadius = 5
        btnDismiss.layer.shadowColor = UIColor.black.cgColor
        btnDismiss.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnDismiss.layer.shadowOpacity = 0.5
        btnDismiss.layer.shadowRadius = 5
        btnDismiss.layer.borderColor = UIColor.black.cgColor
        btnDismiss.layer.borderWidth = 1
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func close(_ sender: Any) {
    }
}
