//
//  PopOverViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/14/21.
//

import UIKit

class PopOverViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UIGestureRecognizerDelegate  {
    
    let button = UIButton(frame: CGRect(x: 150, y: 380, width: 100, height: 40))
    var lastKnowContentOfsset : CGFloat = 0.0

    let tableview: UITableView = {
            let tv = UITableView()
            tv.backgroundColor = UIColor.white
            tv.translatesAutoresizingMaskIntoConstraints = false
            return tv
        }()
    
    var filesDict:NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.backgroundColor = .yellow
                button.setTitle("Close", for: .normal)
        
        let shadowPath1 = UIBezierPath(rect: button.bounds)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowPath = shadowPath1.cgPath
        button.layer.shadowRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)

        self.tableview.addSubview(button)
        
        setupTableView()
        // Do any additional setup after loading the view.
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableview {
            let contentOffset = scrollView.contentOffset.y
            button.frame.origin.y = 380 + scrollView.contentOffset.y
            print("contentOffset: ", contentOffset)
            if (contentOffset > self.lastKnowContentOfsset) {
                print("scrolling Down")
                print("dragging Up")
            } else {
                print("scrolling Up")
                print("dragging Down")
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableview {
            self.lastKnowContentOfsset = scrollView.contentOffset.y
            print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
        }
    }
    
    func setupTableView() {
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.keyboardDismissMode = .onDrag
        
        tableview.register(TableViewCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return filesDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.white
        cell.itemView.text = Array(filesDict)[indexPath.row].value as? String
        cell.pathView.text = Array(filesDict)[indexPath.row].key as? String
        cell.pathView.tag = 2
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if filesDict.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        WhatToDoAlert(fileName: Array(filesDict)[indexPath.row].value as? String ?? "Not Available", filePath: Array(filesDict)[indexPath.row].key as? String ?? "Not Available")
    }
    
    @objc func dismissView()
    {
        UIView.animate(withDuration: 2, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.alpha = 0.0
        }, completion: nil)
        
        //self.view.removeFromSuperview()
        
    }
    
    func TapAlert(fileName : String, filePath : String)
    {
        let alert = UIAlertController(title: fileName, message: filePath, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func WhatToDoAlert(fileName : String, filePath : String)
    {
        let alert = UIAlertController(title: "Choose Action", message: "What would you like to do?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Show Path", style: .default, handler: { _ in  self.TapAlert(fileName : fileName, filePath : filePath)}))
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
}

