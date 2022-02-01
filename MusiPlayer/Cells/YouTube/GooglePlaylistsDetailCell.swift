//
//  GooglePlaylistsDetailCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/2/21.
//

import UIKit


protocol GooglePlaylistsDetail: AnyObject {
    func didTap(_ cell: GooglePlaylistsDetailCell)
}

class GooglePlaylistsDetailCell: UITableViewCell {
    
    var delegate: GooglePlaylistsDetail?

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chanTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descr: UITextView!
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var prevPage: UILabel!
    @IBOutlet weak var nextPage: UILabel!
    @IBOutlet weak var btnGoTo: UIButton!
    @IBOutlet weak var videoId: UILabel!
    
    
    
    var playList: PlaylistsGoogle!
    
    {
        didSet {
            self.updatePlayListItemsUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatePlayListItemsUI()
    {
        btnGoTo.layer.masksToBounds = false
        btnGoTo.layer.cornerRadius = 5
        btnGoTo.layer.shadowColor = UIColor.black.cgColor
        btnGoTo.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        btnGoTo.layer.shadowOpacity = 0.5
        btnGoTo.layer.shadowRadius = 5
        btnGoTo.layer.borderColor = UIColor.black.cgColor
        btnGoTo.layer.borderWidth = 1
        
        chanTitle.text = (playList.snippet!["channelTitle"] as! String)
        print((playList.snippet!["title"] as! String))
        title.text = (playList.snippet!["title"] as! String)
        print((playList.snippet!["description"] as! String))
        print(playList.snippet as Any)
        videoId.text = ((playList.snippet!["resourceId"] as! [String: Any]) ["videoId"] as! String)

        descr.text = (playList.snippet!["description"] as! String)
        descr.backgroundColor = UIColor.white
        descr.textColor = UIColor.black
        prevPage.text = playList.prevPageToken
        nextPage.text = playList.nextPageToken
        
        
        print(nextPage.text as Any)
        print(prevPage.text as Any)
        lblID.text = (playList.id!)
        
        let thumbDict:[String:Any] = playList.snippet!["thumbnails"] as! [String:Any]
        print(thumbDict)
        
        print(thumbDict["default"] as Any)
        
        if thumbDict["default"] != nil{
            let subDict:[String:Any] = thumbDict["default"] as! [String : Any]
            print(subDict["url"] as Any)

            self.imgView.image = nil
            
            self.imgView.downloaded(from: subDict["url"] as! String)
        }

    }
    @IBAction func playItem(_ sender: Any) {
        delegate?.didTap(self)

    }
    
}
