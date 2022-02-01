//
//  SettingsViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 6/13/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var txtAbout: UITextView!
    @IBOutlet weak var btnClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtAbout.backgroundColor = UIColor.white
        txtAbout.textColor = UIColor.black

        let defaults = UserDefaults.standard
        if UserDefaults.standard.object(forKey: "About") != nil
        {
            txtAbout.text = defaults.string(forKey: "About")
        }
        
        btnClose.layer.masksToBounds = false
        btnClose.layer.cornerRadius = 5
        btnClose.layer.shadowColor = UIColor.darkGray.cgColor
        btnClose.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnClose.layer.shadowOpacity = 0.5
        btnClose.layer.shadowRadius = 5
        btnClose.layer.borderColor = UIColor.black.cgColor
        btnClose.layer.borderWidth = 1
        btnClose.layer.backgroundColor = UIColor.white.cgColor
        
        txtAbout.layer.masksToBounds = false
        txtAbout.layer.cornerRadius = 5
        txtAbout.layer.shadowColor = UIColor.lightGray.cgColor
        txtAbout.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        txtAbout.layer.shadowOpacity = 0.5
        txtAbout.layer.shadowRadius = 5
        txtAbout.layer.borderColor = UIColor.blue.cgColor
        txtAbout.layer.borderWidth = 5
        txtAbout.layer.backgroundColor = UIColor.white.cgColor
    }
    

    @IBAction func btnCloseTap(_ sender: Any) {
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

}
