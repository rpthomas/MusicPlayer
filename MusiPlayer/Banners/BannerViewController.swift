//
//  BannerViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/22/21.
//

import UIKit

class BannerViewController: UIViewController {

    let popupBox: UIView = {
           let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .green
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
                createTheView()
    }
    
    private func createTheView() {

        let xCoord = 50
            let yCoord = 50 

        let centeredView = UIView(frame: CGRect(x: Int(xCoord), y: yCoord, width: Int(self.view.bounds.width) - 100 , height: 50))
            centeredView.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        centeredView.layer.masksToBounds = false
        centeredView.layer.cornerRadius = 5
        centeredView.layer.shadowColor = UIColor.black.cgColor
        centeredView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        centeredView.layer.shadowOpacity = 0.5
        centeredView.layer.shadowRadius = 5
        centeredView.layer.borderColor = UIColor.black.cgColor
        centeredView.layer.borderWidth = 1
        
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: centeredView.bounds.width, height: 40))
        label.textAlignment = .center
        label.text = "Saved"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        centeredView.addSubview(label)

        self.view.addSubview(centeredView)
        
        performAfter(delay: 2) {
           print("task to be done")
        }
    }
    
        func performAfter(delay: TimeInterval, completion: @escaping () -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

  
    


