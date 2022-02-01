//
//  VideoViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/6/21.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices
import MessageUI
import MobileCoreServices


//Class
public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

class VideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ImagePickerDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate{
    
    
 
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    private var imagePickerController = UIImagePickerController()
    private weak var delegate: ImagePickerDelegate?

    
    @IBOutlet weak var videoPicker: UIPickerView!
    
    @IBOutlet weak var mediaPicker: UIPickerView!
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var lblMediaType: UILabel!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var btnBrowseMovies: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    let vodeoLocations = ["Photo Library","Web URL","Local Path"]
    let mediaTypes = ["Images","Videos"]
    
    var videoText:String = ""
    var mediaText:String = ""
    
    var loadedImage:UIImage? = nil
    var loadedImageData:Data? = nil
    var loadedImageName: String = ""
    var savedImage = true
    var mediaType:String = "Image"
    var theUrl: URL = URL(string: "http://")!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result){
        case MessageComposeResult.cancelled:
            print("Message cancelled");
            break;
        case MessageComposeResult.sent:
            print("Message sent");
            let alertController = UIAlertController(title: "Done", message:
                    "Message Sent!!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            break;
        case MessageComposeResult.failed:
            print("Message sent failure: %@", result);
            let alertController = UIAlertController(title: "Message Send Failure", message:
                    "Message Could Not Be Sent!!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)

            break;
        default:
            break;
        }
        // Close the Mail Interface
        controller.dismiss(animated: true)
        }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
                switch (result){
                case MFMailComposeResult.cancelled:
                    print("Mail cancelled");
                    break;
                case MFMailComposeResult.saved:
                    print("Mail saved");
                    break;
                case MFMailComposeResult.sent:
                    print("Mail sent");
                    let alertController = UIAlertController(title: "Done", message:
                            "Mail Sent!!", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))


                    break;
                case MFMailComposeResult.failed:
                    print("Mail sent failure: %@", error?.localizedDescription as Any);
                    let alertController = UIAlertController(title: "Mail Send Failure", message:
                            "Mail Could Not Be Sent!!", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                    break;
                default:
                    break;
                }
                // Close the Mail Interface
        controller.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        setUp()
        videoText = vodeoLocations[0]
        mediaText = mediaTypes[0]
        
        
        let res = ResourceAPI()
        res.resetDefaults()
        
        let rd = ReadWrite()
        rd.clearCache()
        self.hideKeyboardWhenTappedAround()
        AppleMusicAPI().getMethod()
        
 //       var developerToken:String = ""

//        let rd = ReadWrite()
//        developerToken = rd.readText()
//        print(developerToken)
//        developerToken = developerToken.replacingOccurrences(of: "\"", with: "")
//
//        if developerToken == ""
//        {
//            let defaults = UserDefaults.standard
//            developerToken = defaults.string(forKey: "DeveloperToken") ?? ""
//            rd.writeText(str: developerToken)
//        }

        //let res = ResourceAPI()
        //res.getDefaultReset()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
            
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
      

       
     }
    override func viewWillAppear(_ animated: Bool) {
        



    }
    
    override func viewDidAppear(_ animated: Bool) {
           }
    
func setUp()
{
    self.imagePickerController = UIImagePickerController()
    self.delegate = self

    self.imagePickerController.delegate = self
    self.imagePickerController.allowsEditing = true

    videoPicker.delegate = self
    videoPicker.dataSource = self
    
    mediaPicker.delegate = self
    mediaPicker.dataSource = self
    
    videoPicker.layer.masksToBounds = false
    videoPicker.layer.cornerRadius = 5
    videoPicker.layer.shadowColor = UIColor.black.cgColor
    videoPicker.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    videoPicker.layer.shadowOpacity = 0.5
    videoPicker.layer.shadowRadius = 5
    videoPicker.layer.borderColor = UIColor.black.cgColor
    videoPicker.layer.borderWidth = 1
    
    mediaPicker.layer.masksToBounds = false
    mediaPicker.layer.cornerRadius = 5
    mediaPicker.layer.shadowColor = UIColor.black.cgColor
    mediaPicker.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    mediaPicker.layer.shadowOpacity = 0.5
    mediaPicker.layer.shadowRadius = 5
    mediaPicker.layer.borderColor = UIColor.black.cgColor
    mediaPicker.layer.borderWidth = 1
      
    txtUrl.layer.masksToBounds = false
    txtUrl.layer.shadowRadius = 3.0
    txtUrl.layer.shadowColor = UIColor.black.cgColor
    txtUrl.layer.shadowOffset = CGSize(width: 1.0,height:  1.0)
    txtUrl.layer.shadowOpacity = 1.0
    
    txtUrl.isHidden = true
    
    btnLoad.layer.masksToBounds = false
    btnLoad.layer.cornerRadius = 5
    btnLoad.layer.shadowColor = UIColor.black.cgColor
    btnLoad.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    btnLoad.layer.shadowOpacity = 0.5
    btnLoad.layer.shadowRadius = 5
    btnLoad.layer.borderColor = UIColor.black.cgColor
    btnLoad.layer.borderWidth = 1
    
    btnLoad.isHidden = true
    
    btnBrowseMovies.layer.masksToBounds = false
    btnBrowseMovies.layer.cornerRadius = 5
    btnBrowseMovies.layer.shadowColor = UIColor.black.cgColor
    btnBrowseMovies.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    btnBrowseMovies.layer.shadowOpacity = 0.5
    btnBrowseMovies.layer.shadowRadius = 5
    btnBrowseMovies.layer.borderColor = UIColor.black.cgColor
    btnBrowseMovies.layer.borderWidth = 1
    btnBrowseMovies.setTitle("Show Images", for: .normal)
    
    imgView.layer.masksToBounds = false
    imgView.layer.cornerRadius = 5
    imgView.layer.shadowColor = UIColor.black.cgColor
    imgView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    imgView.layer.shadowOpacity = 0.5
    imgView.layer.shadowRadius = 5
    imgView.layer.borderColor = UIColor.black.cgColor
    imgView.layer.borderWidth = 1
    imgView.layer.backgroundColor = UIColor.black.cgColor
    
    btnFile.layer.masksToBounds = false
    btnFile.layer.cornerRadius = 5
    btnFile.layer.shadowColor = UIColor.black.cgColor
    btnFile.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    btnFile.layer.shadowOpacity = 0.5
    btnFile.layer.shadowRadius = 5
    btnFile.layer.borderColor = UIColor.black.cgColor
    btnFile.layer.borderWidth = 1
    btnFile.setTitle("File", for: .normal)
    
    btnSettings.layer.masksToBounds = false
    btnSettings.layer.cornerRadius = 5
    btnSettings.layer.shadowColor = UIColor.black.cgColor
    btnSettings.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    btnSettings.layer.shadowOpacity = 0.5
    btnSettings.layer.shadowRadius = 5
    btnSettings.layer.borderColor = UIColor.black.cgColor
    btnSettings.layer.borderWidth = 1
    btnSettings.setTitle("About", for: .normal)
    
    btnTakePhoto.layer.masksToBounds = false
    btnTakePhoto.layer.cornerRadius = 5
    btnTakePhoto.layer.shadowColor = UIColor.black.cgColor
    btnTakePhoto.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    btnTakePhoto.layer.shadowOpacity = 0.5
    btnTakePhoto.layer.shadowRadius = 5
    btnTakePhoto.layer.borderColor = UIColor.black.cgColor
    btnTakePhoto.layer.borderWidth = 1
    btnTakePhoto.setTitle("Camera", for: .normal)
}
    
    @IBAction func HelpTap(_ sender: Any) {
        self.displayChoicesAlert()
    }
    
    func displayChoicesAlert()
    {
        let alert = UIAlertController(title: "Choose", message: "What would you like to do?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Show About", style: .default, handler: { _ in  self.showAbout()}))
        
        alert.addAction(UIAlertAction(title: "Contact Support", style: .default, handler: { _ in  self.sendSupportEmail()}))

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    func showAbout()
    {
        self.performSegue(withIdentifier: "showAbout", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showAbout" {
           if let settingsController = segue.destination as? SettingsViewController {
                settingsController.modalPresentationStyle = .fullScreen
                //settingsController.parentView = self
            //self.view.backgroundColor = .lightGray

           }
       }
        else
        {
            //var  path:String = theUrl.absoluteString
            //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
            if verifyUrl(urlString : theUrl.absoluteString)
            {
                let destination = segue.destination as!
                                                AVPlayerViewController
                
                guard let myURL = URL(string: txtUrl.text!) else {
                    return
                }
                
                
                destination.player = AVPlayer(url: myURL)
                    destination.player?.play()
            }
            else
            {
                let player = AVPlayer(url: theUrl)  // video path coming from above function

                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        self.present(playerViewController, animated: true) {
                            playerViewController.player!.play()
                        }
                
    //            let destination = segue.destination as!
    //                                            AVPlayerViewController
    //
    //             let myURL = theUrl
    //
    //
    //            destination.player = AVPlayer(url: myURL)
    //                destination.player?.play()
            }
        }
    }
    
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self!.hideOnLoad()
                self?.imgView.image = UIImage(data: data)
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    // MARK: - Photo Library
    func openCameraForVideo() {
        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self

        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
        mediaType = "Video"

        present(imagePickerController, animated: true, completion: nil)
    }
    
    func openCameraForImage() {
        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self

        //imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeVideo as String]
        imagePickerController.mediaTypes = ["public.image"]
        mediaType = "Image"

        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func openCameraTakePhoto() {
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self

        //mediaType = "Image"

        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func browseMovies(_ sender: Any) {
        
        
        
        if btnBrowseMovies.currentTitle == "Hide Image"
        {
            
            btnBrowseMovies.setTitle("Show Images", for: .normal)
            lblLocation.fadeIn(2)
            videoPicker.fadeIn(2)
            lblMediaType.fadeIn(2)
            mediaPicker.fadeIn(2)
            imgView.fadeOut(2)
            
            if videoText == "Web URL"
            {
                txtUrl.fadeIn(2)
            }
            
            return
        }
        print(videoText)
        switch (videoText) {
                    case "Photo Library":
                        switch (mediaText) {
                            case "Images":
                                openCameraForImage()
                            case "Videos":
                                openCameraForVideo()
                            default:
                                break
                            }
                    case "Web URL": //Add a TextBox
                        if txtUrl.isHidden == false && txtUrl.text!.count > 5
                        {
                            if self.verifyUrl(urlString: txtUrl.text )
                            {
                                //let url1 : String = txtUrl.text!
                                let imageExtensions = ["png", "jpg", "gif", "tiff"]
                                let movieExtensions = ["m4v", "mp4", "mov"]
                                //...
                                // Iterate & match the URL objects from your checking results
                                       
                                let url = URL(string: txtUrl.text!)!
                                theUrl = url
                                let pathExtention = url.pathExtension
                                
                                if imageExtensions.contains(pathExtention)
                                {
                                    print("Image URL: \(String(describing: url))")
                                            
                                    downloadImage(from: url)
                                    imgView.fadeIn(2)
                                }
                                else if movieExtensions.contains(pathExtention)
                                    {
                                        performSegue(withIdentifier: "ShowPlayer", sender: nil)
                                    }
                                else
                                {
                                    let alertController = UIAlertController(title: "Invalid URL", message:
                                            "Cannot detertine type of media!", preferredStyle: .alert)
                                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                        self.present(alertController, animated: true, completion: nil)
                                }
                            }
                            else
                            {
                                let alertController = UIAlertController(title: "Invalid URL", message:
                                        "URL is not correctly formatted!", preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                    self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        else{
                            noURLAlert()
                            
                        }
                        
                    case "Local Path":
                        performSegue(withIdentifier: "ShowPlayer", sender: nil)
                    default:
                        break
                    
                        }   
        
            }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        openCameraTakePhoto()
    }
    
    // MARK: - Picker View
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

     let videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
     print(videoURL!)
     imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1
        {
            return vodeoLocations.count
        }
        else
        {
            return mediaTypes.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1
        {
            return vodeoLocations[row]
        }
        else
        {
            return mediaTypes[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        switch pickerView {
           case videoPicker:
            videoText = vodeoLocations[row]
            var isEqual = (videoText == "Photo Library")
            if isEqual
            {
                mediaPicker.isHidden = false
                mediaLabel.isHidden = false
                txtUrl.isHidden = true
                lblMediaType.text = "Select Media Type"
                self.view.endEditing(true)
                btnLoad.isHidden = true
                btnBrowseMovies.isHidden = false
                
                let areEqual = ("Images" == mediaText)
                if areEqual
                {
                    btnBrowseMovies.setTitle("Show Images", for: .normal)
                }
                else
                {
                    btnBrowseMovies.setTitle("Show Videos", for: .normal)
                }
                
                
            }
            else{
                isEqual = (videoText == "Web URL")
                if isEqual
                {
                    mediaPicker.isHidden = true
                    txtUrl.isHidden = false
                    lblMediaType.text = "Enter Image / Video URL"
                    btnLoad.isHidden = true
                    btnBrowseMovies.setTitle("Browse", for: .normal)
                    btnBrowseMovies.isHidden = false
                }
                else
                {
                    lblMediaType.text = "Load Media from Documents Directory"
                    lblMediaType.isHidden = false
                    mediaPicker.isHidden = true
                    mediaLabel.isHidden = false
                    txtUrl.isHidden = true
                    btnLoad.isHidden = false
                    btnBrowseMovies.isHidden = true
                }
            }
           case mediaPicker:
            mediaText = mediaTypes[row]
            NSLog(mediaText as String)
            txtUrl.isHidden = true
            lblMediaType.isHidden = false
            lblMediaType.text = "Select Media Type"
            //let atEqual = ("Images" == mediaText)
            btnBrowseMovies.isHidden = false
            switch (videoText)
            {
                case "Photo Library":
                    if mediaText == "Images"
                    {
                        mediaType = "Image"
                        btnBrowseMovies.setTitle("Show Images", for: .normal)
                    }
                    else
                    {
                        mediaType = "Video"
                        btnBrowseMovies.setTitle("Show Videos", for: .normal)
                    }
            default:
                break
            }
           default:
               break
           }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
            
        var label = UILabel()
            if let v = view as? UILabel { label = v }
        
        label.font = UIFont(name: "Marker Felt", size: 20.0)

        switch pickerView {
           case videoPicker:
            label.text = vodeoLocations[row] as String
            label.textColor = UIColor.black
            label.textAlignment = .center
            break
        
           case mediaPicker:
            label.text = mediaTypes[row] as String
            label.textColor = UIColor.black
            label.textAlignment = .center
            
            break
           default:
               break
           }
      
      
      return label
    }
    
    func showPopUp(fileDict: NSMutableDictionary)
    {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopOverView") as! PopOverViewController

        self.addChild(popOverVC)

                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
        popOverVC.filesDict = fileDict
        popOverVC.didMove(toParent: self)
    }

    
    func didSelect(image: UIImage?) {
        
    }
    
    //========================
    // MARK: Save Image to Documents Directory and Photo Album
    
    func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
        
        theUrl = URL(string: "http://")!
        print(mediaType)
        if mediaType == "Image"
        {
            guard let image = info[.editedImage] as? UIImage else
            {
                print("Image Not Found")
                return
            }
            let imageName = UUID().uuidString
        
            //let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                
                loadedImage = image
                loadedImageData = jpegData
                loadedImageName = imageName
                
             
                
                hideControls(img: image)
            
            }
        }
        else if mediaType == "Video"
        {
            guard let url = info[.mediaURL] as? URL else {
               print("Video Not Found")
                InvalidUrlAlert()
                return
           }
            
            
            theUrl = url
            //theUrl = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
            
            
            videoChoiceAlert()
            
        }
            
            
    }
    
    func hideControls(img: UIImage)
    {
        lblLocation.fadeOut(2)
        videoPicker.fadeOut(2)
        lblMediaType.fadeOut(2)
        mediaPicker.fadeOut(2)
        imgView.fadeIn(2)
        imgView.image = img
        btnBrowseMovies.setTitle("Hide Image", for: .normal)
    }
    
    func hideOnLoad()
    {
        txtUrl.fadeOut(2)
        lblLocation.fadeOut(2)
        videoPicker.fadeOut(2)
        lblMediaType.fadeOut(2)
        mediaPicker.fadeOut(2)
        imgView.fadeIn(2)
        btnBrowseMovies.setTitle("Hide Image", for: .normal)
    }
    @IBAction func loadMedia(_ sender: Any) {
        mediaTypeAlert()
        
    }
    
  
    
    //Save and Get Image from Document Directory in Swift
    //https://iswiftdeveloper.wordpress.com/2018/01/30/save-and-get-image-from-document-directory-in-swift/
    
    
    //how to save image to photo library in ios
    //https://www.google.com/search?q=how+to+save+image+to+photo+library+in+ios&oq=how+to+save+image+to+photo+library&aqs=chrome.0.0i457j69i57j0i22i30l6.710165j1j15&sourceid=chrome&ie=UTF-8
    
    
    //Save and Get Image from Document Directory in Swift
    //https://iswiftdeveloper.wordpress.com/2018/01/30/save-and-get-image-from-document-directory-in-swift/
    

    
    // MARK: Alerts
    func noURLAlert()
    {
        let alertController = UIAlertController(title: "No URL", message:
                "Please type a URL!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func showFileAlert(_ sender: Any) {
        
        print(imgView.alpha)
        if imgView.alpha == 0.0
        {
            NoImageAlert()
            return
        }
        
        let title:String =  mediaText + " Options"
        let alert = UIAlertController(title: title, message: "Save or Send Image.", preferredStyle: .alert)
        
        let clsWrite = ReadWrite()
        
        if savedImage == false
        {
            alert.addAction(UIAlertAction(title: "Save to Camera Roll", style: .default, handler: { [self] _ in  clsWrite.writeToPhotoAlbum(image : imgView.image!)}))
        }
        
        alert.addAction(UIAlertAction(title: "Save to Hidden Folder", style: .default, handler: { [self]  _ in
            if clsWrite.saveImageToDocumentDirectory(imgView : self.imgView){
                //self.DoneAlert()
                presentPopup()
            }else
            {
                self.FailedAlert()
            }
        }))
        
        if savedImage == true
        {
            alert.addAction(UIAlertAction(title: "Export to Camera Roll", style: .default, handler: { [self] _ in  clsWrite.writeToPhotoAlbum(image : imgView.image!)}))
        }
        
        alert.addAction(UIAlertAction(title: "Send Text", style: .default, handler: { _ in  self.sendText()}))
        
        alert.addAction(UIAlertAction(title: "Send Email", style: .default, handler: { _ in  self.sendEmail()}))
                
        alert.addAction(UIAlertAction(title: "Delete Files", style: .default, handler: { _ in  self.DoubleCheckAlert()}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))


        
        self.present(alert, animated: true)
        
    }
    
    
    func DoubleCheckAlert()
    {
        let clsDelete = ReadWrite()
        
        let title:String = "Warning!!!"
        let alert = UIAlertController(title: title, message: "This action will delete all files in the hidden folder!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
                                        clsDelete.clearCache()}))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func DoneAlert()
    {
        let title:String = "Done"
        let alert = UIAlertController(title: title, message: "Saved", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func FailedAlert()
    {
        let title:String = "Failed"
        let alert = UIAlertController(title: title, message: "Failed to Save", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    
    func NoImageAlert()
    {
        let title:String = "No " + mediaText
        let alert = UIAlertController(title: title, message: "There are no " + mediaText + " to Send", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    func AlreadySavedAlert()
    {
        let title:String = "Alreade Saved"
        let alert = UIAlertController(title: title, message: "This item has already been saved.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
     func mediaTypeAlert() {

        let title:String = "Media Types"
        let alert = UIAlertController(title: title, message: "What type of media to load?", preferredStyle: .alert)
        
        var filesDict : NSMutableDictionary = [:]
        
        let clsRead = ReadWrite()
        alert.addAction(UIAlertAction(title: "Images", style: .default, handler: { [self] _ in
            filesDict = clsRead.readFromDocumentsDirectory(imgtype: "Images")
            showPopUp(fileDict : filesDict)
        }))
        
        alert.addAction(UIAlertAction(title: "Videos", style: .default, handler: { [self] _ in
            filesDict = clsRead.readFromDocumentsDirectory(imgtype: "Videos")
            showPopUp(fileDict : filesDict)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func sendText()
    {
       
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        // Configure the fields of the interface.
        composeVC.recipients = nil
        composeVC.body = "Sent by Jedisware's Multi-Media Player"
        
        if mediaText == "Image"
        {
            if (loadedImage != nil)
            {
                if MFMessageComposeViewController.canSendAttachments() {
                    let imageData = imgView.image!.jpegData(compressionQuality: 1.0)
                    composeVC.addAttachmentData(imageData!, typeIdentifier: "image/jpg", filename: "photo.jpg")
                    }
                else
                {
                    NoTextAlert()
                }
            }
        }
        else
        {
            if MFMessageComposeViewController.canSendAttachments() {
                
                let videoURL = theUrl
                print(videoURL)
                
                
          
                //let pathExtension = videoURL.pathExtension
                
//                if let fileData = NSData(contentsOf: videoURL) {
//
//                    composeVC.addAttachmentData(fileData as Data, typeIdentifier: pathExtension, filename: "myfile." + pathExtension)
//                       }
                
                let imageData = imgView.image!.jpegData(compressionQuality: 1.0)
                composeVC.addAttachmentData(imageData!, typeIdentifier: "image/jpg", filename: "photo.jpg")
                }
            else
            {
                NoTextAlert()
            }
        }
        

        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        }
        else{
            let title:String = "Not Available"
            let alert = UIAlertController(title: title, message: "Sending Text Not Available!" , preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

            
            self.present(alert, animated: true)
        }

    }
    
    func sendSupportEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@Jedisware.biz"])
            mail.setMessageBody("<p>Sent by Jedisware's Multi-Media Player</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            NoMailAlert()
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            //mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>Sent by Jedisware's Multi-Media Player</p>", isHTML: true)
            
            if mediaText == "Image"
            {
                if (loadedImage != nil)
                {
                    let imageData = imgView.image!.jpegData(compressionQuality: 1.0)
                    mail.addAttachmentData(imageData!, mimeType: "image/jpg", fileName: "photo.jpg")
                }
            }
            else
            {
                let videoURL = theUrl
                let pathExtension = videoURL.pathExtension

                if let fileData = NSData(contentsOf: videoURL) {

                    mail.addAttachmentData(fileData as Data, mimeType: pathExtension, fileName: "myfile." + pathExtension)
                    }
            }

            present(mail, animated: true)
        } else {
            NoMailAlert()
        }
    }
    
    
    
    func NoMailAlert()
    {
        let alert = UIAlertController(title: "Cannot Send", message: "Unable to send Email.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func NoTextAlert()
    {
        
        let alert = UIAlertController(title: "Cannot Send", message: "Unable to send Text.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func InvalidUrlAlert()
    {
        
        let alert = UIAlertController(title: "Invalid URL", message: "Video cannot be played.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    
    func videoChoiceAlert()
    {
        let title:String = "Select an option"
        let alert = UIAlertController(title: title, message: "What wuld you like to do?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Video", style: .default, handler: { [self] _ in
            performSegue(withIdentifier: "ShowPlayer", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Send Text", style: .default, handler: { [self] _ in
                                        
                                        self.sendText()}))
        
        alert.addAction(UIAlertAction(title: "Send Email", style: .default, handler: { [self] _ in
                                        self.sendEmail()}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func mimeType(url : URL) -> String {
        let pathExtension = url.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    func presentPopup() {
            let popupVC = BannerViewController()
            popupVC.definesPresentationContext = true
            popupVC.modalPresentationStyle = .custom
            popupVC.modalTransitionStyle = .crossDissolve
            present(popupVC, animated: true, completion: nil)
    }

}
extension UIView {
  func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: duration) {
        self.alpha = alpha
      }
    }
  }

  func fadeIn(_ duration: TimeInterval = 0.3) {
    fadeTo(1.0, duration: duration)
  }

  func fadeOut(_ duration: TimeInterval = 0.3) {
    fadeTo(0.0, duration: duration)
  }
    
    
    
}


extension AVAsset {
    // Provide a URL for where you wish to write
    // the audio file if successful
    func writeAudioTrack(to url: URL,
                         success: @escaping () -> (),
                         failure: @escaping (Error) -> ()) {
        do {
            let asset = try audioAsset()
            asset.write(to: url, success: success, failure: failure)
        } catch {
            failure(error)
        }
    }

    private func write(to url: URL,
                       success: @escaping () -> (),
                       failure: @escaping (Error) -> ()) {
        // Create an export session that will output an
        // audio track (M4A file)
        guard let exportSession = AVAssetExportSession(asset: self,
                                                       presetName: AVAssetExportPresetAppleM4A) else {
                                                        // This is just a generic error
                                                        let error = NSError(domain: "domain",
                                                                            code: 0,
                                                                            userInfo: nil)
                                                        failure(error)

                                                        return
        }

        exportSession.outputFileType = .m4a
        exportSession.outputURL = url

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                success()
            case .unknown, .waiting, .exporting, .failed, .cancelled:
                let error = NSError(domain: "domain", code: 0, userInfo: nil)
                failure(error)
            @unknown default:
                print(exportSession.status)
                //fatalError()
            }
        }
    }

    private func audioAsset() throws -> AVAsset {
        // Create a new container to hold the audio track
        let composition = AVMutableComposition()
        // Create an array of audio tracks in the given asset
        // Typically, there is only one
        let audioTracks = tracks(withMediaType: .audio)

        // Iterate through the audio tracks while
        // Adding them to a new AVAsset
        for track in audioTracks {
            let compositionTrack = composition.addMutableTrack(withMediaType: .audio,
                                                               preferredTrackID: kCMPersistentTrackID_Invalid)
            do {
                // Add the current audio track at the beginning of
                // the asset for the duration of the source AVAsset
                try compositionTrack?.insertTimeRange(track.timeRange,
                                                      of: track,
                                                      at: track.timeRange.start)
            } catch {
                throw error
            }
        }

        return composition
    }
}




//extension AVAsset {
//
//    func writeAudioTrackToURL(_ url: URL, completion: @escaping (Bool, Error?) -> ()) {
//        do {
//            let audioAsset = try self.audioAsset()
//            audioAsset.writeToURL(url, completion: completion)
//        } catch (let error as NSError){
//            completion(false, error)
//        }
//    }
//
//    func writeToURL(_ url: URL, completion: @escaping (Bool, Error?) -> ()) {
//
//        guard let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetAppleM4A) else {
//            completion(false, nil)
//            return
//        }
//
//        exportSession.outputFileType = .m4a
//        exportSession.outputURL      = url
//
//        exportSession.exportAsynchronously {
//            switch exportSession.status {
//            case .completed:
//                completion(true, nil)
//            case .unknown, .waiting, .exporting, .failed, .cancelled:
//                completion(false, nil)
//             default:
//             break
//            }
//        }
//    }
//
//    func audioAsset() throws -> AVAsset {
//
//        let composition = AVMutableComposition()
//        let audioTracks = tracks(withMediaType: .audio)
//
//        for track in audioTracks {
//
//            let compositionTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
//            try compositionTrack?.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
//            compositionTrack?.preferredTransform = track.preferredTransform
//        }
//        return composition
//    }
//}

//    var containsImage: Bool {
//        let mimeType = theUrl.mimeType()
//        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
//            return false
//        }
//        return UTTypeConformsTo(uti, kUTTypeImage)
//    }
//    var containsAudio: Bool {
//        let mimeType = theUrl.mimeType()
//        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
//            return false
//        }
//        return UTTypeConformsTo(uti, kUTTypeAudio)
//    }
//    var containsVideo: Bool {
//        let mimeType = theUrl.mimeType()
//        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
//            return false
//        }
//        return UTTypeConformsTo(uti, kUTTypeMovie)
//    }



//How to use it:
//
//// fadeIn() - always animates to alpha = 1.0
//yourView.fadeIn()     // uses default duration of 0.3
//yourView.fadeIn(1.0)  // uses custom duration (1.0 in this example)
//
//// fadeOut() - always animates to alpha = 0.0
//yourView.fadeOut()    // uses default duration of 0.3
//yourView.fadeOut(1.0) // uses custom duration (1.0 in this example)
//
//// fadeTo() - used if you want a custom alpha value
//yourView.fadeTo(0.5)  // uses default duration of 0.3
//yourView.fadeTo(0.5, duration: 1.0)

//https://gist.github.com/deepakpk009/99fd994da714996b296f11c3c371d5ee
//"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
//"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
