//
//  iTunesSelectionViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/31/21.
//

import UIKit

class iTunesSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    
    @IBOutlet weak var txtSearchTerm: UITextField!
    
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var criteriaPicker: UIPickerView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var sortedCountriesArray = [String]()
    
    var sortedPickerOneArray = [String]()
    var sortedPickerTwoArray = [String]()
    
    var country = ""
    var term: String = ""
    var entity: String = ""
    var media: String = ""
    var attribute: String? = ""
    @IBOutlet weak var lblSearchDescription: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        
        self.hideKeyboardWhenTappedAround()

        
        sortedCountriesArray = Array(countriesDict.values)
        sortedCountriesArray.sort()
        
        sortedPickerOneArray = pickerOneArray
        sortedPickerOneArray.sort()
        
        criteriaPicker.selectRow(0, inComponent: 0, animated: true)
        
        
        sortedPickerTwoArray = audioBookEnum.allCases.map { $0.description }
        sortedPickerTwoArray.sort()
         
        setDefaults()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
    }
    
    func setUp()
    {
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        criteriaPicker.delegate = self
        criteriaPicker.dataSource = self
        
        countryPicker.layer.masksToBounds = false
        countryPicker.layer.cornerRadius = 5
        countryPicker.layer.shadowColor = UIColor.black.cgColor
        countryPicker.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        countryPicker.layer.shadowOpacity = 0.5
        countryPicker.layer.shadowRadius = 5
        countryPicker.layer.borderColor = UIColor.black.cgColor
        countryPicker.layer.borderWidth = 1
        
        criteriaPicker.layer.masksToBounds = false
        criteriaPicker.layer.cornerRadius = 5
        criteriaPicker.layer.shadowColor = UIColor.black.cgColor
        criteriaPicker.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        criteriaPicker.layer.shadowOpacity = 0.5
        criteriaPicker.layer.shadowRadius = 5
        criteriaPicker.layer.borderColor = UIColor.black.cgColor
        criteriaPicker.layer.borderWidth = 1
          
        txtSearchTerm.layer.masksToBounds = false
        txtSearchTerm.layer.shadowRadius = 5.0
        txtSearchTerm.layer.shadowColor = UIColor.black.cgColor
        txtSearchTerm.layer.shadowOffset = CGSize(width: 10.0,height:  10.0)
        txtSearchTerm.layer.shadowOpacity = 0.5
        txtSearchTerm.layer.borderColor = UIColor.black.cgColor
        txtSearchTerm.layer.borderWidth = 1
        txtSearchTerm.layer.cornerRadius = 5

        
        btnSearch.layer.masksToBounds = false
        btnSearch.layer.cornerRadius = 5
        btnSearch.layer.shadowColor = UIColor.black.cgColor
        btnSearch.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnSearch.layer.shadowOpacity = 0.5
        btnSearch.layer.shadowRadius = 5
        btnSearch.layer.borderColor = UIColor.black.cgColor
        btnSearch.layer.borderWidth = 1

    }
    
    func setDefaults()
    {
        let index = sortedCountriesArray.firstIndex(of: "United States of America")
        countryPicker.selectRow(index!, inComponent: 0, animated: true)
        
        //country
        if let key = countriesDict.first(where: { $0.value == "United States of America" })?.key {
            country = key
            print("country: " + key)
        }
        
        var selectedItem = self.sortedPickerOneArray[0]
    
        //media
        media = mediaDict[selectedItem]!
        print("media: " + media)

        //entity
        selectedItem = self.sortedPickerTwoArray[0]
        entity = enityDict[selectedItem]!
        print("entity: " + entity)
        
        //arrtibute
        selectedItem = self.sortedPickerTwoArray[0]
        attribute = attributesDict[selectedItem]!
        print("attribute: " + attribute!)
        
        lblSearchDescription.text = "Enter Book Title:"
        
    }
  
    
    @IBAction func sendRequest(_ sender: Any) {
        

        
    }
    
    func isValidParams() -> Bool{
        if txtSearchTerm.text!.count < 3
        {
            print(entity)
            if entity == "tvSeason"
            {
                if txtSearchTerm.text!.count < 1
                {
                    missingTermAlert()
                    return false
                }
                else
                {
                    return true
                }
            }
            else
            {
                missingTermAlert()
                return false
            }
        }
        else if txtSearchTerm.text!.containsSpecialCharacters(string: txtSearchTerm.text!){
                        invalidCharacterAlert()
            return false
        }
        else
        {
            return true
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == countryPicker {
                return 1
            } else {
                return 2
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == countryPicker {
            return sortedCountriesArray.count
        }
        else
        {
            if component == 0 {
                return sortedPickerOneArray.count
            } else
            {
                return sortedPickerTwoArray.count
            }
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return sortedCountriesArray[row]
        }
        else
        {
           if component == 0
           {
                return sortedPickerOneArray[row]
           }
            else
           {
            return sortedPickerTwoArray[row]
           }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        if pickerView != countryPicker {
          var title = UILabel()
             if let view = view {
                    title = view as! UILabel
              }
            title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
            title.textColor = UIColor.black
            if component == 0
            {
                title.text = sortedPickerOneArray[row]
            }
             else
            {
                title.text = sortedPickerTwoArray[row]
            }
            title.textAlignment = .center

            return title
        }
        else
        {
            var title = UILabel()
               if let view = view {
                      title = view as! UILabel
                }
              title.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.bold)
            title.textColor = UIColor.black

                  title.text = sortedCountriesArray[row]
              
              title.textAlignment = .center

              return title
        }
        
    }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
            
            var secondSelectedItem: String = ""
            var setRow:Bool = false
            if pickerView == countryPicker {
                let selectedItem = self.sortedCountriesArray[row]
                print(selectedItem)
                //country
                if let key = countriesDict.first(where: { $0.value == selectedItem})?.key {
                    country = key
                    print("country: " + key)
                }
            }
            else
            {
               if component == 0
               {
                    let selectedItem = self.sortedPickerOneArray[row]
                
                    if selectedItem != "Media"
                    {
                        media = mediaDict[selectedItem]!
                        print("media: " + media)
                    }
                    switch selectedItem
                    {
                        case "Audio Books":
                            sortedPickerTwoArray = audioBookEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            lblSearchDescription.text = "Search in Title / Description"
                            setRow = true
                        case "Media":
                            sortedPickerTwoArray.removeAll()
                            lblSearchDescription.text = "All Media Containing:"
                            media = "all"
                            entity = "movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack"
                            setRow = true
                        case "Movie":
                            sortedPickerTwoArray = movieEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            lblSearchDescription.text = "Movie Title Containing:"
                            media = mediaDict[selectedItem]!
                            entity = enityDict[selectedItem]!
                            print(media)
                            print(entity)
                            attribute = "movieTerm"
                            setRow = true
                        case "Music":
                            sortedPickerTwoArray = musicEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            lblSearchDescription.text = "Album Title with Name Like:"
                            media = mediaDict[selectedItem]!
                            entity = "album"
                            attribute = attributesDict["Album"]
                            setRow = true
                        case "Music Video":
                            sortedPickerTwoArray = musicVideoEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            lblSearchDescription.text = "Video with Name Like:"
                            media = mediaDict[selectedItem]!
                            entity = "musicVideo"
                            attribute = attributesDict["Music Video"]
                            setRow = true
                        case "Podcast":
                            sortedPickerTwoArray = podCastEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            media = mediaDict[selectedItem]!
                            entity = "podcastAuthor"
                            attribute = attributesDict["Pod Cast Author"]
                            lblSearchDescription.text = "Podcast Author with Name Like:"
                            setRow = true
                        case "Software":
                            sortedPickerTwoArray = softwareEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            entity = "software,iPadSoftware,macSoftware"
                            lblSearchDescription.text = "Enter Software Name:"
                            attribute = nil
                            setRow = true
                        case "Television":
                            sortedPickerTwoArray = televisionEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            lblSearchDescription.text = "Where Description Contains:"
                            entity = "tvEpisode"
                            attribute = attributesDict["TV Episode"]
                            setRow = true
                        default:
                            sortedPickerTwoArray = audioBookEnum.allCases.map { $0.description }
                            sortedPickerTwoArray.sort()
                            
                    }
 
               }
                else
               {
                let selectedItem = self.sortedPickerTwoArray[row]
                entity = enityDict[selectedItem]!
                print("entity: " + entity)
                
                secondSelectedItem = self.sortedPickerTwoArray[row]
                let check: String? = attributesDict[secondSelectedItem]
                 if let _ = check
                {
                    attribute = attributesDict[secondSelectedItem]!
                    print("attribute: " + attribute!)
                }
                else
                 {
                    attribute = nil
                 }
                
                switch secondSelectedItem
                {
                    case "Audio Book":
                        lblSearchDescription.text = "Enter Book Title:"
                    case "Audio Book Author":
                        lblSearchDescription.text = "Enter Author Name:"
                    case "Movie":
                        lblSearchDescription.text = "Movie Title Containing:"
                        //entity = enityDict[secondSelectedItem]!
                        //attribute = attributesDict[secondSelectedItem]
                    case "Movie Artist":
                        lblSearchDescription.text = "Artist with Name Like:"
                        media = "movie"
                        //entity = enityDict[secondSelectedItem]!
                        //attribute = attributesDict[secondSelectedItem]
                    case "Album":
                        lblSearchDescription.text = "Album Title with Name Like:"
                        //media = mediaDict[selectedItem]!
                        //entity = enityDict[secondSelectedItem]!
                        //attribute = attributesDict[secondSelectedItem]
                    case "Music Artist":
                        lblSearchDescription.text = "Artist with Name Like:"
                        //media = mediaDict[selectedItem]!
                        //entity = enityDict[secondSelectedItem]!
                        //attribute = attributesDict[secondSelectedItem]
                    case "Music Track":
                        lblSearchDescription.text = "Song with Name Like:"
                        //media = mediaDict[selectedItem]!
                        //entity = enityDict[secondSelectedItem]!
                        //attribute = attributesDict[secondSelectedItem]
                    case "Music Video":
                        lblSearchDescription.text = "Video with Name Like:"
                    case "Music Video Artist":
                        lblSearchDescription.text = "Video with Artist Name Like:"
                    case "Podcasts":
                        lblSearchDescription.text = "Podcast with Title Like:"
                    case "Pod Cast Author":
                        lblSearchDescription.text = "Podcast Author with Title Like:"
                    case "All Software":
                        lblSearchDescription.text = "Enter Software Name:"
                    case "Mac Software":
                        lblSearchDescription.text = "Enter Software Name:"
                    case "iPhone Software":
                        lblSearchDescription.text = "Enter Software Name:"
                    case "iPad Software":
                        lblSearchDescription.text = "Enter Software Name:"
                    case "TV Episode":
                        lblSearchDescription.text = "Where Description Contains:"
                    case "TV Season":
                        lblSearchDescription.text = "Enter value for Season (e.g. 2 or second):"
                    case "Software Developer":
                        lblSearchDescription.text = "Enter Developers Name:"

                    default:
                        lblSearchDescription.text = "Enter Book Title"
                        
                }

               }
            }
        
            if pickerView != countryPicker {
                pickerView.reloadComponent(1)

            }
            if setRow
            {
                setRow = false
                criteriaPicker.selectRow(0, inComponent: 1, animated: true)
                
            }
            
        }
    
    func invalidCharacterAlert()
    {
        let alertController = UIAlertController(title: "Invalid Character", message:
                "Special characters and punctuation cannot be used!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }
    
    func missingTermAlert()
    {
        let alertController = UIAlertController(title: "Missing Search Term", message:
                "Please enter what you are searching for!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if isValidParams()
        {
            if segue.identifier == "segITunes" {
                if let appleViewController = segue.destination as? AppStoreViewController {
                    
                    appleViewController.term = txtSearchTerm.text!
                    appleViewController.entity = entity
                    appleViewController.media = media
                    if let _ = attribute
                    {
                        appleViewController.attribute = attribute!
                    }
                    else
                    {
                        appleViewController.attribute = nil
                    }
                    appleViewController.modalPresentationStyle = .fullScreen
                    
                    print(media)
                    //print("attribute: " + attribute!)
                    if attribute == nil && media == "software" {
                        print("country: " + country)
                        print("Text: " + txtSearchTerm.text! as Any)
                        print("Enity: " + entity)
                        print("Media: " + media)
                        //print("attribute: " + attribute! as Any)
                        
                        appleViewController.fetchApps(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media)
                    }
                    else{
                        print("country: " + country)
                        print("Text: " + txtSearchTerm.text! as Any)
                        print("Enity: " + entity)
                        print("Media: " + media)
                        print("attribute: " + attribute! as Any)
                        
                        switch( media, entity )
                        {
                            case ("audiobook","audiobook"):
                                appleViewController.fetchAudioBooks(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("audiobook","audiobookAuthor"):
                                appleViewController.fetchAudioBooks(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("all","movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack"):
                                appleViewController.fetchMedia(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("movie","movie"):
                                appleViewController.fetchMovies(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("movie","movieArtist"):
                                appleViewController.fetchMovieArtists(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("music","album"):
                                appleViewController.fetchMusicAlbums(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("music","musicArtist"):
                                appleViewController.fetchMusicArtists(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("music","musicTrack"):
                                appleViewController.fetchMusicTrack(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("musicVideo","musicVideo"):
                                appleViewController.fetchMusicVideos(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("musicVideo","musicArtist"):
                                appleViewController.fetchMusicVideoArtists(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("podcast","podcast"):
                                appleViewController.fetchPodcasts(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("podcast","podcastAuthor"):
                                appleViewController.fetchpodcastAuthor(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("tvShow","tvEpisode"):
                                appleViewController.fetchTV(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("tvShow","tvSeason"):
                                appleViewController.fetchTV(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                            case ("software","software"):
                                if attribute == "softwareDeveloper"
                                {
                                    appleViewController.fetchSoftwareDev(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                                }
                                else {
                                    appleViewController.fetchApps(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                                }
                                
                            default:
                                appleViewController.fetchApps(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)

                        }
//                        appleViewController.fetchApps(inCountry: country, withTerm: txtSearchTerm.text!, inEntity: entity, inMedia: media, inAttribute: attribute!)
                    }
                }
            }
        }
        
    }
    
    

}
extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

extension String {

  func containsSpecialCharacters(string: String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) {
                return true
            } else {
                return false
            }
        } catch {
            debugPrint(error.localizedDescription)
            return true
        }
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
