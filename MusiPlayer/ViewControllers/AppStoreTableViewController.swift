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
    var books: [AudioBook]?
    var mod_media: [Media]?
    var movieObj: [Movies]?
    var music: [Music]?
    var softDev: [SoftwareDeveloper]?
    var tv: [Television]?
    var appStoreClient = AppStoreClient()
    var country = ""
    var term: String = ""
    var entity: String = ""
    var media: String = ""
    var attribute: String? = ""
    var callType = ("", "")
    
    // TODO: create a search controller in this TVC
    
    struct Storyboard {
        static let appCell = "AppCell"
        //static let bookCell = "BookCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchApps()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        //self.tableView.register(MusiPlayer.BookTableViewCell.self, forCellReuseIdentifier: Storyboard.bookCell)
        
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
          headerView.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        
          let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
        labelView.isUserInteractionEnabled = true
          //labelView.text = "My header view"
        
         let button = UIButton(frame: CGRect(x: 5, y: 0, width: 100, height: 20))
          button.backgroundColor = .blue
          button.setTitle("Back", for: .normal)
        
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
        button.isUserInteractionEnabled = true
          button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

   labelView.addSubview(button)
          
          headerView.addSubview(labelView)
          self.tableView.tableHeaderView = headerView
        
        
    }
    
    //iTunes Search Examples                                                  To include iPad
    //http://itunes.apple.com/search?term=Gameloft&country=us&entity=software,iPadSoftware&limit=100
    
    //"http://itunes.apple.com/search?media=music&term=2&country=it&limit=60&attribute=genreIndex&entity=song&callback=?"
    
    func fetchApps()
    {
        print("1") //, inMedia: "all"
        appStoreClient.fetchApps(withTerm: "Miracles", inEntity: "software,iPadSoftware") { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        appStoreClient.fetchApps(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String)
    {
        print("1") //, inMedia: "all"
        appStoreClient.fetchApps(inCountry : country, withTerm: term, inEntity: entity) { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String)
    {
        print("1") //, inMedia: "all"
        appStoreClient.fetchApps(inCountry : country, withTerm: term, inEntity: entity, inMedia: media) { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchAudioBooks(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchAudioBooks(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (books) in
            
            self.books = books
            print(self.books as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMedia(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMedia(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (media) in
            
            self.mod_media = media
            print(self.mod_media as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMovies(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMovies(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (movies) in
            
            self.movieObj = movies
            print(self.mod_media as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMovieArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMovieArtists(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (movies) in
            
            self.movieObj = movies
            print(self.mod_media as Any)
            self.tableView.reloadData()
        }
    }
    
    @objc @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch( callType.0, callType.1 )
        {
            case ("audiobook","audiobook"):
                if let books = books {
                    return books.count
                }
                
                return 0
            case ("all","movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack"):
                if let media = mod_media {
                    return media.count
                }
                
                return 0
            case ("movie","movie"):
                if let movie = movieObj {
                    return movie.count
                }
                
                return 0
            case ("movie","movieArtist"):
                if let movie = movieObj {
                    return movie.count
                }
                
                return 0

            case ("software","software"):
                if let apps = apps {
                    return apps.count
                }
                
                return 0
            default:
                if let apps = apps {
                    return apps.count
                }
                
                return 0
        }
        
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch( callType.0, callType.1 )
        {
            case ("audiobook","audiobook"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.book = books?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("all","movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.media = mod_media?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("movie","movie"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.movies = movieObj?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("movie","movieArtist"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.movieArtist = movieObj?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("music","album"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.music = music?[indexPath.row]
                cell.selectionStyle = .none

                return cell

            case ("software","software"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell

                if attribute == "softwareDeveloper"
                {
                    cell.softDev = softDev?[indexPath.row]
                    cell.selectionStyle = .none
                }
                else{
                        cell.app = apps?[indexPath.row]
                        cell.selectionStyle = .none
                }

                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell

                cell.app = apps?[indexPath.row]
                cell.selectionStyle = .none

                return cell
        }

    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    

}










