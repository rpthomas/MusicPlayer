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
