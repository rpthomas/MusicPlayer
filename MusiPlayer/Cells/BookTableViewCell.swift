//
//  BookTableViewCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/9/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCollectionName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var appStoreLink: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    var book: AudioBook!
    
    {
        didSet {
            self.updateUI()
        }
    }
    
     func viewDidLoad()
    {
        //updateUI()
    }
    
    func updateUI()
    {
       // print(lblCollectionName.text! as String)
        print(book.name! as String)
        if let check = book.name{
            print(check)
            print(check)
            lblCollectionName.text = check
            print(check)
        }
        lblCollectionName.text = book.name
        
        let testString: String? = book.iTunesUrl?.absoluteString

        if case appStoreLink.text = testString
        {
            appStoreLink.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked))
            tap.name = book.iTunesUrl?.absoluteString
            
            appStoreLink.addGestureRecognizer(tap)
        }
        
        lblGenre.text = book.primaryGenre
        
        lblDescription.text = book.descript
        
        if book.collectPrice == 0 {
            lblPrice.text = "N/A"
            
        } else {
            lblPrice.text = "$\(book.collectPrice)"
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
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        if superview != nil {
//            updateUI()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
//        label.text = @"Fork me on GitHub! (https://github.com/mattt/TTTAttributedLabel/)"; // Repository URL will be automatically detected and linked
//        NSRange range = [label.text rangeOfString:@"me"];
//        [label addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
    }
    
    @objc func labelClicked(_ recognizer: UITapGestureRecognizer)
    {
        print(recognizer.name as Any)
        UIApplication.shared.open(URL(string: recognizer.name!)!)
    }


}
