//
//  MediaPlayerViewController.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/5/21.
//

import UIKit
import MediaPlayer
import AVFoundation

class MediaPlayerViewController: UIViewController, MPMediaPickerControllerDelegate {

    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var showMediaPicker: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var mediaPicker: MPMediaPickerController!
    //var musicPlayer: MPMusicPlayerController?
    //let masterVolumeSlider: MPVolumeView = MPVolumeView()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblAlbum: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
              // setUp()
    }

  
    
    func setUp()
    {
//        let shadowPath3 = UIBezierPath(rect: btnSpotifyLogin.bounds)
//        btnSpotifyLogin.layer.masksToBounds = false
//        btnSpotifyLogin.layer.cornerRadius = 5
//        btnSpotifyLogin.layer.shadowColor = UIColor.black.cgColor
//        btnSpotifyLogin.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//        btnSpotifyLogin.layer.shadowOpacity = 0.5
//        btnSpotifyLogin.layer.shadowPath = shadowPath3.cgPath
//        btnSpotifyLogin.layer.shadowRadius = 5
//
//        btnSpotifyLogin.layer.borderColor = UIColor.black.cgColor
//        btnSpotifyLogin.layer.borderWidth = 1
//
//
//
//        lblLogon.layer.masksToBounds = false
//        lblLogon.layer.shadowRadius = 3.0
//        lblLogon.layer.shadowColor = UIColor.black.cgColor
//        lblLogon.layer.shadowOffset = CGSize(width: 1.0,height:  1.0)
//        lblLogon.layer.shadowOpacity = 1.0
//
//        lblPassword.layer.masksToBounds = false
//        lblPassword.layer.shadowRadius = 3.0
//        lblPassword.layer.shadowColor = UIColor.black.cgColor
//        lblPassword.layer.shadowOffset = CGSize(width: 1.0,height:  1.0)
//        lblPassword.layer.shadowOpacity = 1.0
    }
    
   
//    @IBAction func showPicker(_ sender: Any) {
//        displayMediaPickerAndPlayItem()
//    }
//
//    @IBAction func previousTap(_ sender: Any) {
//    }
//
//    @IBAction func playTap(_ sender: Any) {
//    }
//
//    @IBAction func forwardTap(_ sender: Any) {
//    }
//
//    @IBAction func volumeChanged(_ sender: Any) {
//    }
//
//    func mediaPicker(mediaPicker: MPMediaPickerController,
//            didPickMediaItems mediaItemCollection: MPMediaItemCollection){
//
//
//        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
//        musicPlayer.beginGeneratingPlaybackNotifications()
//        musicPlayer.setQueue(with: mediaItemCollection)
//        mediaPicker.dismiss(animated: true)
//            // Begin playback.
//        musicPlayer.play()
//        //self.updateNowPlayingItem()
//
//
//
//        }

    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // Get the system music player.
       // let musicPlayer = MPMusicPlayerController.systemMusicPlayer
//        musicPlayer.setQueue(with: mediaItemCollection)
//        mediaPicker.dismiss(animated: true)
//        // Begin playback.
//        musicPlayer.play()
    }
//
//        func displayMediaPickerAndPlayItem(){
//            let controller = MPMediaPickerController(mediaTypes: .music)
//                controller.allowsPickingMultipleItems = true
//            controller.popoverPresentationController?.sourceView = self.view
//                controller.delegate = self
//                present(controller, animated: true)
//        }
//
//        func nowPlayingItemIsChanged(notification: NSNotification){
//
//            print("Playing Item Is Changed")
//
//            let key = "MPMusicPlayerControllerNowPlayingItemPersistentIDKey"
//
//            let persistentID =
//            notification.userInfo![key] as? NSString
//
//            if let id = persistentID{
//                print("Persistent ID = \(id)")
//            }
//
//        }
//
//        func volumeIsChanged(notification: NSNotification){
//            print("Volume Is Changed")
//        }
        
//        func updateNowPlayingItem(){
//            if let nowPlayingItem=self.musicPlayer!.nowPlayingItem{
//                let nowPlayingTitle = nowPlayingItem.title
//                let nowPlayingArtist = nowPlayingItem.albumArtist
//                let nowPlayingTrackArtist = nowPlayingItem.artist
//                let nowPlayingAlbum = nowPlayingItem.albumTitle
//
//                self.lblTitle.text = nowPlayingTitle
//                let artist = nowPlayingArtist ?? "" + " / ("
//                let tractArtist = nowPlayingTrackArtist ?? "" + ")"
//                self.lblArtist.text = artist + tractArtist
//                self.lblAlbum.text = nowPlayingAlbum
//            }else{
//                self.lblTitle.text="Nothing Played"
//            }
//        }
    
}

