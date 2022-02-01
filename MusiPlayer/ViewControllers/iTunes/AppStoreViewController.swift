//
//  AppStoreViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/16/21.
//

import UIKit

class AppStoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
    var apps: [App]?
    var books: [AudioBook]?
    var mod_media: [Media]?
    var movieObj: [Movies]?
    var music: [Music]?
    var musicVid: [MusicVideo]?
    var musicVidArt: [MusicVideoArtist]?
    var podcast: [Podcast]?
    var podAuthor: [PodcastAuthor]?
    var softDev: [SoftwareDeveloper]?
    var tv: [Television]?
    var appStoreClient = AppStoreClient()
    var country = ""
    var term: String = ""
    var entity: String = ""
    var media: String = ""
    var attribute: String? = ""
    var callType = ("", "")
    var message = UILabel()

    
    // TODO: create a search controller in this TVC
    
    struct Storyboard {
        static let appCell = "AppCell"
        //static let bookCell = "BookCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchApps()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        //self.tableView.register(MusiPlayer.BookTableViewCell.self, forCellReuseIdentifier: Storyboard.bookCell)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 40, width: screenWidth, height: 30))
        headerView.backgroundColor =  .lightGray
        //UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
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
        button.setTitleColor(.yellow, for: .normal)
        button.isUserInteractionEnabled = true
          button.addTarget(self, action: #selector(myUnwindAction), for: .touchUpInside)

        labelView.addSubview(button)
          
        headerView.addSubview(labelView)
        self.view.addSubview(headerView)
        
        
        message.text = "No Results Found"
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.textAlignment = .center

        self.view.addSubview(message)

        message.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    
    @objc @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

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
        print("1")
        appStoreClient.fetchApps(inCountry : country, withTerm: term, inEntity: entity) { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchApps(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String)
    {
        print("1")
        appStoreClient.fetchApps(inCountry : country, withTerm: term, inEntity: entity, inMedia: media) { (apps) in
            
            self.apps = apps
            print(self.apps as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchAudioBooks(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1")
        
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
    
    func fetchMusicAlbums(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMusicAlbums(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (music) in
            
            self.music = music
            print(self.music as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMusicArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMusicArtists(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (music) in
            
            self.music = music
            print(self.music as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMusicTrack(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMusicTrack(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (music) in
            
            self.music = music
            print(self.music as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchMusicVideos(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMusicVideos(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (musicVid) in
            
            self.musicVid = musicVid
            print(self.musicVid as Any)
            self.tableView.reloadData()
        }
    }
    
    
    func fetchMusicVideoArtists(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1") //, inMedia: "all"
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchMusicVideoArtists(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (musicVidArt) in
            
            self.musicVidArt = musicVidArt
            print(self.musicVidArt as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchpodcastAuthor(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchpodcastAuthor(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (podAuthor) in
            
            self.podAuthor = podAuthor
            print(self.musicVidArt as Any)
            self.tableView.reloadData()
        }
    }

    
    func fetchPodcasts(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        print("1")
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchPodcasts(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (podcast) in
            
            self.podcast = podcast
            print(self.podcast as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchSoftwareDev(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        
        callType.0 = media
        callType.1 = entity
        
        appStoreClient.fetchSoftwareDev(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (softDev) in
            
            self.softDev = softDev
            print(self.mod_media as Any)
            self.tableView.reloadData()
        }
    }
    
    func fetchTV(inCountry country: String, withTerm term: String, inEntity entity: String, inMedia media: String, inAttribute attribute: String)
    {
        callType.0 = media
        callType.1 = entity

        appStoreClient.fetchTV(inCountry : country, withTerm: term, inEntity: entity, inMedia: media, inAttribute : attribute) { (tv) in
            
            self.tv = tv
            print(self.tv as Any)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch( callType.0, callType.1 )
        {
            case ("audiobook","audiobook"):
                if let books = books {
                    self.message.isHidden = true
                    return books.count
                }
                
                return 0
            case ("all","movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack"):
                if let media = mod_media {
                    self.message.isHidden = true
                    return media.count
                }
                
                return 0
            case ("movie","movie"):
                if let movie = movieObj {
                    self.message.isHidden = true
                    return movie.count
                }
                
                return 0
            case ("movie","movieArtist"):
                if let movie = movieObj {
                    self.message.isHidden = true
                    return movie.count
                }
                
                return 0
            case ("music","album"):
                if let music = music {
                    self.message.isHidden = true
                    return music.count
                }
                
                return 0

            case ("music","musicArtist"):
                if let music = music {
                    self.message.isHidden = true
                    return music.count
                }
                
                return 0
            case ("music","musicTrack"):
                if let music = music {
                    self.message.isHidden = true
                    return music.count
                }
                
                return 0
                
            case ("musicVideo","musicVideo"):
                if let musicVid = musicVid {
                    self.message.isHidden = true
                    return musicVid.count
                }
                
                return 0
                
            case ("musicVideo","musicArtist"):
                if let musicVidArt = musicVidArt {
                    self.message.isHidden = true
                    return musicVidArt.count
                }
                
                return 0

            case ("podcast","podcast"):
                if let podcast = podcast {
                    self.message.isHidden = true
                    return podcast.count
                }
                
                return 0

            case ("podcast","podcastAuthor"):
                if let podAuthor = podAuthor {
                    self.message.isHidden = true
                    return podAuthor.count
                }
                
                return 0

            case ("software","software"):
                if attribute == "softwareDeveloper"
                {
                    if let softDev = softDev {
                        self.message.isHidden = true
                           return softDev.count
                        }
                }
                else
                {
                    if let apps = apps {
                        self.message.isHidden = true
                           return apps.count
                        }
                }
                    return 0
                
            case ("tvShow","tvEpisode"):
                if let tv = tv {
                    self.message.isHidden = true
                   return tv.count
                }
                
                return 0
            case ("tvShow","tvSeason"):
                if let tv = tv {
                    self.message.isHidden = true
                   return tv.count
                }
                
                return 0

            default:
                if let apps = apps {
                    self.message.isHidden = true
                    return apps.count
                }
                
                return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(callType.0)
        print(callType.1)
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
                
            case ("music","musicArtist"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.music = music?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("music","musicTrack"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.music = music?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("musicVideo","musicVideo"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.musicVid = musicVid?[indexPath.row]
                cell.selectionStyle = .none

                return cell

            case ("musicVideo","musicArtist"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.musicVidArt = musicVidArt?[indexPath.row]
                cell.selectionStyle = .none

                return cell
                
            case ("podcast","podcast"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.podcast = podcast?[indexPath.row]
                cell.selectionStyle = .none

                return cell

            case ("podcast","podcastAuthor"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.podAuthor = podAuthor?[indexPath.row]
                cell.selectionStyle = .none

                return cell

            case ("software","software"):
                    let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell

                if attribute == "softwareDeveloper"
                {
                    cell.softDev = softDev?[indexPath.row]
                    cell.selectionStyle = .none
                }
                else
                {
                    cell.app = apps?[indexPath.row]
                    cell.selectionStyle = .none
                }
                
                    return cell
                
            case ("tvShow","tvEpisode"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.tv = tv?[indexPath.row]
                cell.selectionStyle = .none

                return cell
            case ("tvShow","tvSeason"):
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
                
                cell.tv = tv?[indexPath.row]
                cell.selectionStyle = .none

                return cell

            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell

                cell.app = apps?[indexPath.row]
                cell.selectionStyle = .none

                return cell
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
