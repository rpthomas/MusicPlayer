//
//  TableViewCell.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 1/14/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()

        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    let cellView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let itemView: UITextView = {
            let tView = UITextView()
            tView.text = "Item 1"
            tView.textColor = UIColor.black
            tView.font = UIFont.boldSystemFont(ofSize: 16)
            tView.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
            tView.isScrollEnabled = true
            tView.showsVerticalScrollIndicator = true
            tView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            tView.tag = 1
//            label.lineBreakMode = .byWordWrapping
//            label.numberOfLines = 2;
                
            tView.translatesAutoresizingMaskIntoConstraints = false
            return tView
        }()
    
    let pathView: UITextView = {
        let pView = UITextView()
        pView.text = "Path 1"
        pView.textColor = UIColor.black
        pView.font = UIFont.boldSystemFont(ofSize: 14)
        pView.backgroundColor = UIColor(red: 0.8389534697, green: 0.9051236194, blue: 1, alpha: 1)
        pView.isScrollEnabled = true
        pView.showsVerticalScrollIndicator = true
        pView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        pView.tag = 2
        
//        pView.lineBreakMode = .byWordWrapping
//        pView.numberOfLines = 2;
        
        pView.translatesAutoresizingMaskIntoConstraints = false
        return pView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(itemView)
        cellView.addSubview(pathView)
        self.selectionStyle = .none

        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        itemView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        itemView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        itemView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width - 170
        
        pathView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pathView.widthAnchor.constraint(equalToConstant: width).isActive = true
        pathView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        pathView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 150).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func viewDidLayoutSubviews()
    {
        itemView.centerVertically()
        pathView.centerVertically()
    }
}

extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
