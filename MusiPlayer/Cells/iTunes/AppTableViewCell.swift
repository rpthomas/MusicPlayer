//
//  AppTableViewCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import UIKit

class AppTableViewCell: UITableViewCell
{
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var appNameLabel: UILabel!
    //@IBOutlet weak var appDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lnkApple: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    var app: App! {
        didSet {
            self.updateUI()
        }
    }
    
    var book: AudioBook!
    
    {
        didSet {
            self.updateBookUI()
        }
    }
    
    var media: Media!
    
    {
        didSet {
            self.updateMediaUI()
        }
    }
    
    var movies: Movies!
    
    {
        didSet {
            self.updateMovieUI()
        }
    }
    
    var movieArtist: Movies!
    
    {
        didSet {
            self.updateMovieArtistUI()
        }
    }
    
    var music: Music!
    
    {
        didSet {
            self.updateMusicUI()
        }
    }
    
    var musicVid: MusicVideo!
    
    {
        didSet {
            self.updateMusicVideoUI()
        }
    }
    
    var musicVidArt: MusicVideoArtist!
    
    {
        didSet {
            self.updateMusicVideoArtistUI()
        }
    }
    
    var podcast: Podcast!
    
    {
        didSet {
            self.updatePodcastUI()
        }
    }
    
    var podAuthor: PodcastAuthor!
    
    {
        didSet {
            self.updatePodAuthorUI()
        }
    }
    
    var softDev: SoftwareDeveloper!
    
    {
        didSet {
            self.updateSoftwareDevUI()
        }
    }
    
    var tv: Television!
    
    {
        didSet {
            self.updateTVUI()
        }
    }
    
    func updateUI()
    {
        appNameLabel.text = app.name
        
        let testString: String? = app.itunesUrl?.absoluteString

        if case appNameLabel.text = testString
        {
            appNameLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = app.itunesUrl?.absoluteString
            
            appNameLabel.addGestureRecognizer(tap)
        }
        
                
        let stripped = app.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        txtView.text = stripped
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        
        if app.price == 0 {
            priceLabel.text = app.formattedPrice
            
        } else {
            priceLabel.text = app.price.toCurrency()
        }
        
        self.artworkImageView.image = nil
        if let url = app.artworkUrl {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    func updateMediaUI()
    {
        if media.kind != ""
        {
            lblType.text = "Type: " + media.kind!
        }
        else { lblType.text = "Type: " + media.wrapper!}
              
        
        if media.name == "" && media.artistName != ""
        {
            lblAuthor.text = "Artist: " + media.artistName!
        }
        else if media.name != "" && media.artistName == ""
        {
            lblAuthor.text = "Artist: " + media.name!
        }
        else if media.name != "" && media.artistName != ""
        {
            lblAuthor.text = "Artist: " + media.name!
        }
        else {lblAuthor.text = "N/A"}
        
        appNameLabel.text = media.collectName
        
       
        if media.primaryGenre == ""
        {
            let string = media.genres!.joined(separator: ", ")
            lblGenre.text = "Genre: " + string
        }
        else {lblGenre.text = "Genre: " + media.primaryGenre!}
        
        if let descriptionTest = media.descript
        {
            let stripped = descriptionTest.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            txtView.text = stripped
        }
        else {txtView.text = media.shortDescription}
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        //txtView.backgroundColor = UIColor.white
        //txtView.textColor = UIColor.black
        
        if let priceTest = media.trackPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        else if let priceTest = media.collectPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        
        let testString: String? = media.iTunesUrl?.absoluteString
        //print(testString)
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
        self.artworkImageView.image = nil
        if let url = media.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    func updateBookUI()
    {
        lblType.text = "Type: " + book.wrapper!
        appNameLabel.text = book.collectName
        lblAuthor.text = book.name
        lblGenre.text = "Genre: " + book.primaryGenre
        
        let stripped = book.descript.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        txtView.text = stripped
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        priceLabel.text = String(format: "%f", book.collectPrice)
        if book.collectPrice == 0 {
            print(book.collectPrice)
            priceLabel.text = book.collectPrice.toCurrency()
                
                //String(format: "%f", book.collectPrice)
            
        } else {
            print(book.collectPrice)
            //priceLabel.text = "$\(app.price)"
            priceLabel.text = book.collectPrice.toCurrency()

            //priceLabel.text = String(format: "%f", "$\(book.collectPrice)")
        }
        
        let testString: String? = book.iTunesUrl?.absoluteString
        //print(testString)
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
        self.artworkImageView.image = nil
        if let url = book.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
    }
    
    
    func updateMovieUI()
    {
        if movies.kind != ""
        {
            lblType.text = "Type: " + movies.kind!
        }
        else { lblType.text = "Type: " + movies.wrapper!}
               
  
        lblAuthor.text = "Artist: " + movies.artistName!
         
        appNameLabel.text = "Title: " + movies.trackName!
        
       
        lblGenre.text = "Genre: " + movies.primaryGenre!
        
        if let descriptionTest = movies.descript
        {
            let stripped = descriptionTest.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            txtView.text = stripped
        }
        else {txtView.text = movies.shortDescript}
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        
        if let priceTest = movies.trackPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        else if let priceTest = movies.collectPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        
        if movies.iTunesUrl?.absoluteString != nil{
            let testString: String? = movies.iTunesUrl?.absoluteString
        
            //print(testString)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        else{
            let testString: String? = movies.trackViewUrl?.absoluteString
        
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        
        
        self.artworkImageView.image = nil
        if let url = movies.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    func updateMovieArtistUI()
    {
        
       lblType.text = "Type: " + movieArtist.wrapper!
               
        lblAuthor.text = "Artist: " + movieArtist.artistName!
         
        appNameLabel.isHidden = true
        
        lblGenre.text = "Genre: " + movieArtist.primaryGenre!
        
        txtView.text = movieArtist.artistType
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black


        priceLabel.isHidden = true
        priceLabel.numberOfLines = 0
        priceLabel.text = ""
        
       
        
        
        if movieArtist.artistLinkUrl?.absoluteString != nil{
            let testString: String? = movieArtist.artistLinkUrl?.absoluteString
        
            //print(testString)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
       
        
        
        self.artworkImageView.image = nil
        artworkImageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        
    }
    
    func updateMusicUI()
    {
        if music.kind != ""
        {
            lblType.text = "Type: " + music.kind!
        }
        else if music.collectType != ""
        {
            lblType.text = "Type: " + music.collectType!
        }
        else { lblType.text = "Type: " + music.wrapper!}
               
        lblAuthor.text = "Artist: " + music.artistName!
        print(music.artistName as Any)
        appNameLabel.text = "Title: " + music.trackName!
        
        lblGenre.text = "Genre: " + music.primaryGenre!
        
        txtView.text = "Description not available"
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        if music.trackPrice != 0.00
        {
            if let priceTest = music.trackPrice
            {
                if priceTest == 0 {
                    print(priceTest as Any)
                    priceLabel.text = priceTest.toCurrency()
                } else {
                    print(priceTest as Any)
                    priceLabel.text = "Song: " + priceTest.toCurrency()!
                }
            }
        }
        if music.collectPrice != 0.00 && music.trackPrice == 0.00
        {
             if let priceTest = music.collectPrice
            {
                if priceTest == 0 {
                    print(priceTest as Any)
                    priceLabel.text = priceTest.toCurrency()
                } else {
                    print(priceTest as Any)
                    priceLabel.text = " Album: " + priceTest.toCurrency()!
                }
            }
        }
        print(music.collectionViewUrl as Any)
        if music.collectionViewUrl?.absoluteString != nil{
            let testString: String? = music.collectionViewUrl?.absoluteString
            print(testString as Any)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        else if music.artistLinkUrl?.absoluteString != nil{
            let testString: String? = music.artistLinkUrl?.absoluteString
            print(testString as Any)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        else
        {
            if music.trackViewUrl?.absoluteString != nil{
                let testString: String? = music.artistLinkUrl?.absoluteString
                print(testString as Any)
                if  let optionalString = testString
                {
                    lnkApple.text = "App Store"
                    lnkApple.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                    tap.name = optionalString
                    lnkApple.addGestureRecognizer(tap)
                }
            }
        }
        
        
        self.artworkImageView.image = nil
        if let url = music.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    func updateMusicVideoUI()
    {
        if musicVid.kind != ""
        {
            lblType.text = "Type: " + musicVid.kind!
        }
        else { lblType.text = "Type: " + music.wrapper!}
               
        lblAuthor.text = "Artist: " + musicVid.artistName!
        print(musicVid.artistName as Any)
        appNameLabel.text = musicVid.trackName
        
        lblGenre.text = "Genre: " + musicVid.primaryGenre!
        
        txtView.text = "Album: " + musicVid.collectName!
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        if musicVid.trackPrice != 0.00
        {
            if let priceTest = musicVid.trackPrice
            {
                if priceTest == 0 {
                    print(priceTest as Any)
                    priceLabel.text = priceTest.toCurrency()
                } else {
                    print(priceTest as Any)
                    priceLabel.text = "Song: " + priceTest.toCurrency()!
                }
            }
        }

        print(musicVid.collectionViewUrl as Any)
        if musicVid.collectionViewUrl?.absoluteString != nil{
            let testString: String? = musicVid.collectionViewUrl?.absoluteString
            print(testString as Any)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        else
        {
            let testString: String? = musicVid.artistViewUrl?.absoluteString
            print(testString as Any)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        
        
        
        
        self.artworkImageView.image = nil
        if let url = musicVid.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }

    func updateMusicVideoArtistUI()
    {
        if musicVidArt.artistType != ""
        {
            lblType.text = "Type: " + musicVidArt.artistType!
        }
        else { lblType.text = "Type: " + musicVidArt.wrapper!}
               
        lblAuthor.text = "Artist: " + musicVidArt.artistName!
        print(musicVidArt.artistName as Any)
        appNameLabel.text = ""
        
        lblGenre.text = "Genre: " + musicVidArt.primaryGenre!
        
        txtView.text = ""
        priceLabel.text = ""
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black


        print(musicVidArt.artistLinkUrl as Any)
        if musicVidArt.artistLinkUrl?.absoluteString != nil{
            let testString: String? = musicVidArt.artistLinkUrl?.absoluteString
            print(testString as Any)
            if  let optionalString = testString
            {
                lnkApple.text = "App Store"
                lnkApple.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
                tap.name = optionalString
                lnkApple.addGestureRecognizer(tap)
            }
        }
        
       self.artworkImageView.image = nil
        
        
    }

    
    func updatePodcastUI()
    {
        if podcast.kind != ""
        {
            lblType.text = "Type: " + podcast.kind!
        }
        else { lblType.text = "Type: " + podcast.wrapper!}
              
        lblAuthor.text = "Artist: " + podcast.artistName!
        
        appNameLabel.text = podcast.trackName
        
        

        lblGenre.text = "Genre: " + podcast.primaryGenre!

        let string = podcast.genres!.joined(separator: ", ")
        txtView.text = string
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        //txtView.text = podcast.collectName
        
        print(podcast.genres!)
        if let priceTest = podcast.trackPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        else if let priceTest = podcast.collectPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        
        let testString: String? = podcast.trackViewUrl?.absoluteString
        
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
        self.artworkImageView.image = nil
        if let url = podcast.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    func updatePodAuthorUI()
    {
        if podAuthor.artistType != ""
        {
            lblType.text = "Type: " + podAuthor.artistType!
        }
        else { lblType.text = "Type: " + podAuthor.wrapper!}
              
        lblAuthor.text = "Artist: " + podAuthor.artistName!
        
        appNameLabel.text = podAuthor.artistName
        
        

        lblGenre.text = "Genre: " + podAuthor.primaryGenre!
            
        txtView.text = ""
        priceLabel.text = ""
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        
        let testString: String? = podAuthor.artistLinkUrl?.absoluteString
        
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
    }
    
    func updateSoftwareDevUI()
    {
        if softDev.kind != ""
        {
            lblType.text = "Type: " + softDev.kind!
        }
        else { lblType.text = "Type: " + softDev.wrapper!}
              
        lblAuthor.text = "Seller: " + softDev.sellerName!
        
        appNameLabel.text = softDev.trackName
        
       
        if softDev.genres?.count == 0
        {
            lblGenre.text = "Genre: " + softDev.primaryGenre!
        }
        else {
            let string = softDev.genres!.joined(separator: ", ")
            lblGenre.text = "Genre: " + string
        }
        
        if let descriptionTest = softDev.description
        {
            let stripped = descriptionTest.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            txtView.text = stripped
        }
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        if let priceTest = softDev.price
        {
            print(priceTest as Any)
            priceLabel.text = priceTest.toCurrency()! + "  [Release Date: " + softDev.releaseDate! + "]"
        }
        
        
        let testString: String? = softDev.trackViewUrl?.absoluteString
        //print(testString)
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
        self.artworkImageView.image = nil
        if let url = softDev.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
        
        
    }
    
    
    func updateTVUI()
    {
        if tv.kind != ""
        {
            lblType.text = "Type: " + tv.kind!
        }
        else { lblType.text = "Type: " + tv.wrapper!}
              
        
        if tv.artistName != ""
        {
            lblAuthor.text = "Artist: " + tv.artistName!
        }
        else {lblAuthor.text = "N/A"}
        
        appNameLabel.text = tv.collectName
        
       
       lblGenre.text = "Genre: " + tv.primaryGenre!
        
        if let descriptionTest = tv.description
        {
            let stripped = descriptionTest.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            txtView.text = stripped
        }
        else {txtView.text = tv.shortDescription}
        txtView.backgroundColor = .white
        txtView.textColor = UIColor.black

        if let priceTest = tv.trackPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        else if let priceTest = tv.collectPrice
        {
            if priceTest == 0 {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            } else {
                print(priceTest as Any)
                priceLabel.text = priceTest.toCurrency()
            }
        }
        
        let testString: String? = tv.collectionViewUrl?.absoluteString
        //print(testString)
        if  let optionalString = testString
        {
            lnkApple.text = "App Store"
            lnkApple.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            lnkApple.addGestureRecognizer(tap)
        }
        
        self.artworkImageView.image = nil
        if let url = tv.artwork {
            let request = URLRequest(url: url)
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
        
        
    }
    
    
    @objc func labelClicked(_ recognizer: UITapGestureRecognizer)
    {
        print(recognizer.name as Any)
        UIApplication.shared.open(URL(string: recognizer.name!)!)
    }

}

















