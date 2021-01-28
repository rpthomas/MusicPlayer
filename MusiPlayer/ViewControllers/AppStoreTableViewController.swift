//
//  AppStoreTableViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//


import UIKit

class AppStoreTableViewController: UITableViewController
{
    var apps: [App]?
    var appStoreClient = AppStoreClient()
    
    // TODO: create a search controller in this TVC
    
    struct Storyboard {
        static let appCell = "AppCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchApps()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func fetchApps()
    {
        print("1")
        appStoreClient.fetchApps(withTerm: "instagram", inEntity: "software") { (apps) in
            self.apps = apps
            print(self.apps)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let apps = apps {
            return apps.count
        }
        
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell

        cell.app = apps?[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

}










