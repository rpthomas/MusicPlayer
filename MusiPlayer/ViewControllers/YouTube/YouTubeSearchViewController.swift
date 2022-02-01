//
//  YouTubeSearchViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/22/21.
//

import UIKit

class YouTubeSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {


    @IBOutlet weak var channelPicker: UIPickerView!
    @IBOutlet weak var txtChannel: UITextField!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSearch1: UIButton!
    
    var cancelSeg:Bool = false
    var selectedValue:String = ""
    var searchString:String = ""
    var freeTextSearch: Bool = false
    
    struct Storyboard {
        static let appCell = "AppCell"
        //static let bookCell = "BookCell"
    }
    
    override func viewDidLoad() {
       
        setUp()
        txtChannel.delegate = self
        txtChannel.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
        btnSearch.layer.backgroundColor = UIColor.lightGray.cgColor
        btnSearch.isEnabled = false

    }
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    func setUp()
    {
            
        channelPicker.delegate = self
        channelPicker.dataSource = self
        
        channelPicker.layer.masksToBounds = false
        channelPicker.layer.cornerRadius = 5
        channelPicker.layer.shadowColor = UIColor.black.cgColor
        channelPicker.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        channelPicker.layer.shadowOpacity = 0.5
        channelPicker.layer.shadowRadius = 5
        channelPicker.layer.borderColor = UIColor.black.cgColor
        channelPicker.layer.borderWidth = 1
        
        txtChannel.layer.masksToBounds = false
        txtChannel.layer.shadowRadius = 3.0
        txtChannel.layer.shadowColor = UIColor.black.cgColor
        txtChannel.layer.shadowOffset = CGSize(width: 5.0,height:  10.0)
        txtChannel.layer.shadowOpacity = 1.0
        
        btnClear.layer.masksToBounds = false
        btnClear.layer.cornerRadius = 5
        btnClear.layer.shadowColor = UIColor.black.cgColor
        btnClear.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnClear.layer.shadowOpacity = 0.5
        btnClear.layer.shadowRadius = 5
        btnClear.layer.borderColor = UIColor.black.cgColor
        btnClear.layer.borderWidth = 1
        
        btnSearch.layer.masksToBounds = false
        btnSearch.layer.cornerRadius = 5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.layer.shadowRadius = 5
        btnSearch.layer.borderColor = UIColor.black.cgColor
        btnSearch.layer.borderWidth = 1
       
        btnSearch1.layer.masksToBounds = false
        btnSearch1.layer.cornerRadius = 5
        btnSearch1.layer.shadowColor = UIColor.black.cgColor
        btnSearch1.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnSearch1.layer.shadowOpacity = 0.5
        btnSearch1.layer.shadowRadius = 5
        btnSearch1.layer.borderColor = UIColor.black.cgColor
        btnSearch1.layer.borderWidth = 1
  
           
        btnSearch.isEnabled = false
        selectedValue = UTubeSubscribers(rawValue: 0)!.description

}
    
   
    @objc func textFieldDidChange() {
        if txtChannel.text!.count > 0
        {
            channelPicker.isUserInteractionEnabled = false
            channelPicker.backgroundColor = UIColor.darkGray
            btnSearch1.isEnabled = false
            btnSearch1.layer.backgroundColor = UIColor.lightGray.cgColor

            btnSearch.isEnabled = true
            btnSearch.layer.backgroundColor = UIColor.darkGray.cgColor

            
        }
        else
        {
            channelPicker.isUserInteractionEnabled = true
            btnSearch1.isEnabled = true
            btnSearch1.layer.backgroundColor = UIColor.darkGray.cgColor

            channelPicker.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
                //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        }
    }
    
    
    @IBAction func btnClear(_ sender: Any) {
        txtChannel.text = ""
        freeTextSearch = false
        channelPicker.isUserInteractionEnabled = true
        btnSearch1.isEnabled = true
        btnSearch1.layer.backgroundColor = UIColor.darkGray.cgColor

        btnSearch.isEnabled = false
        btnSearch.layer.backgroundColor = UIColor.lightGray.cgColor

        channelPicker.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
    }
    
    @IBAction func btnSearchTap(_ sender: Any) {
        if channelPicker.isUserInteractionEnabled == false
        {
            if let theCheck = txtChannel.text
            {
                if !checkString(theString: theCheck)
                {
                    cancelSeg = true
                    badInput()
                }
                else
                {
                    searchString = theCheck
                }
            }
            else{
                cancelSeg = true
                badInput()
            }
        }
    }
    
   
    
    func checkString(theString: String)-> Bool
    {
        if theString.count > 2 {return true} else {return false}
    }
    
    func badInput()
    {
        let alertController = UIAlertController(title: "Invalid Search Criteria", message:
                "Please enter search text at least 3 characters long!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        freeTextSearch = true
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
               
                return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UTubeSubscribers.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UTubeSubscribers(rawValue: row)?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
            if let v = view as? UILabel { label = v }
        
        label.font = UIFont(name: "Marker Felt", size: 20.0)

        label.text = UTubeSubscribers(rawValue: row)?.description
        label.textColor = UIColor.black
        label.textAlignment = .center
        
      return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
        selectedValue = UTubeSubscribers(rawValue: row)!.description

        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print(txtChannel.text!)
            if freeTextSearch == true
            {
                
                if let theCheck = txtChannel.text
                {
                    if checkString(theString: theCheck)
                    {
                        let youTubeDisplay = segue.destination as!
                        YouTubeSearchDisplayViewController
                        
                        youTubeDisplay.channelParam = theCheck
                        youTubeDisplay.modalPresentationStyle = .fullScreen
                        //self.view.backgroundColor = .darkGray
                    }
                     
                }
            }
            else
            {

                let youTubeDisplay = segue.destination as!
                YouTubeSearchDisplayViewController
                
                youTubeDisplay.channelParam = selectedValue
                print(selectedValue)
                youTubeDisplay.modalPresentationStyle = .fullScreen
                //self.view.backgroundColor = .darkGray
                youTubeDisplay.parentView = self

            }

        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "seqYouTube" {
            if cancelSeg {
                // Return false to cancel segue with identified Edit Profile
                cancelSeg = false
                return false
            }
        }
        return true
    }
    }
    
    

