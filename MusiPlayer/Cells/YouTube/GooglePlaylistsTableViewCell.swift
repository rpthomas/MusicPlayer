//
//  GooglePlaylistsTableViewCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/26/21.
//

import UIKit

protocol GooglePlaylistsCell: AnyObject {
    func didTap(_ cell: GooglePlaylistsTableViewCell)
}

class GooglePlaylistsTableViewCell: UITableViewCell {
    
    var delegate: GooglePlaylistsCell?

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chanTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descr: UITextView!
    
    @IBOutlet weak var prevPage: UILabel!
    @IBOutlet weak var nextPage: UILabel!
    @IBOutlet weak var btnCoTo: UIButton!
    @IBOutlet weak var lblID: UILabel!
    
    
    var playList: PlaylistsGoogle!
    {
        didSet {
            self.updatePlayListUI()
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
    
    func updatePlayListUI()
    {
        
        btnCoTo.layer.masksToBounds = false
        btnCoTo.layer.cornerRadius = 5
        btnCoTo.layer.shadowColor = UIColor.black.cgColor
        btnCoTo.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btnCoTo.layer.shadowOpacity = 0.5
        btnCoTo.layer.shadowRadius = 5
        btnCoTo.layer.borderColor = UIColor.black.cgColor
        btnCoTo.layer.borderWidth = 1
        
        chanTitle.text = (playList.snippet!["channelTitle"] as! String)
        print((playList.snippet!["title"] as! String))
        title.text = (playList.snippet!["title"] as! String)
        print((playList.snippet!["description"] as! String))

        descr.text = (playList.snippet!["description"] as! String)
        descr.backgroundColor = UIColor.white
        descr.textColor = UIColor.black
        prevPage.text = playList.prevPageToken
        nextPage.text = playList.nextPageToken
        
        print(prevPage.text as Any)
        print(nextPage.text as Any)

        lblID.text = playList.id
        
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
    
    @IBAction func btnLoadItems(_ sender: Any) {
        delegate?.didTap(self)
    }
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
