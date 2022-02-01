//
//  AppleMusicTableViewCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/15/21.
//

import UIKit

protocol AppleMusicCell: AnyObject {
    func didTap(_ cell: GooglePlaylistsTableViewCell)
}
class AppleMusicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var composer: UILabel!
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var song: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var storeLink: UILabel!
    @IBOutlet weak var playId: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    
    
    var delegate: AppleMusicCell?

    var songCls: Song!
    {
        didSet {
            self.updateSongUI()
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
    
    func updateSongUI()
    {
        if songCls.artistName != ""
        {
            artistName.text = "Artist: " + songCls.artistName!
        }
        
        if songCls.composerName != ""
        {
            composer.text = "Composer: " + songCls.composerName!
        }
        
        if songCls.albumName != "" 
        {
            album.text = "Album: " + songCls.albumName!
        }
        
        if songCls.name != ""
        {
            song.text = "Title: " + songCls.name!
        }
        
        if songCls.genreNames!.count > 0
        {
            var gen = songCls.genreNames!.reduce("") { $0 + ", " + $1 }
            if gen.hasPrefix(",")
            {
                gen = String(gen.dropFirst(1))
            }
            genre.text = "Genre:" + gen
        }
        
        let testString: String? = songCls.url?.absoluteString
        //print(testString)
        if  let optionalString = testString
        {
            storeLink.text = "Play -->"
            storeLink.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = optionalString
            storeLink.addGestureRecognizer(tap)
        }
        
        
       
 
        
        self.imgView.image = nil
        let str = songCls.artwork!["url"] as! String
        
        var replaced = str.replacingOccurrences(of: "{w}", with: "60")
        replaced = replaced.replacingOccurrences(of: "{h}", with: "60")

        
        if let url = URL(string: replaced) {
            let request = URLRequest(url: url )
            let networkProcessor = NetworkProcessor(request: request)
            
            networkProcessor.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.imgView.image = UIImage(data: imageData)
                        self.imgView.layer.cornerRadius = 10.0
                        self.imgView.layer.masksToBounds = true
                    }
                }
            })
        }
        lblNext.text = songCls.nextPage
        print(songCls.nextPage)
        
    }
    
    @objc func labelClicked(_ recognizer: UITapGestureRecognizer)
    {
        print(recognizer.name as Any)
        UIApplication.shared.open(URL(string: recognizer.name!)!)
    }


}

