//
//  HomeTableViewCell.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 10.05.2024.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var sourceCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: -Main Cell Configuration
    func mainCellConfiguration(title: String?, imageURL: String?, description: String?, date: String?, source: String?) {
        imageCell.layer.cornerRadius = 18
        DispatchQueue.main.async { [self] in
            imageCell.kf.indicatorType = .activity
            if let imageUrl = imageURL {
                imageCell.kf.setImage(with: URL(string: imageUrl))
            }else{
                imageCell.image = UIImage(systemName: "multiply.square")
            }
             
            titleCell.text = title ?? "No Title"
            descriptionCell.text = description ?? "No Description"
            dateCell.text = date ?? "No Date"
            sourceCell.text = source ?? "No Source"
        }
    }
}
