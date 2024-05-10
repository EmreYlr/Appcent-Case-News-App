//
//  HomeTableViewCell.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 10.05.2024.
//

import UIKit

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
    
}
