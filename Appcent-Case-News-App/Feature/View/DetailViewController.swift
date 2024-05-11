//
//  DetailViewController.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 11.05.2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateImageView: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var sourceButton: UIButton!
    
    var detailViewModel: DetailViewModelProtocol = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
    }
    
    func initLoad() {
        if let article = detailViewModel.article {
            DispatchQueue.main.async { [self] in
                newsImageView.kf.indicatorType = .activity
                if let imageUrl = article.urlToImage {
                    newsImageView.kf.setImage(with: URL(string: imageUrl))
                }else{
                    newsImageView.image = UIImage(systemName: "multiply.square")    
                }
                titleLabel.text = article.title
                authorLabel.text = article.author ?? "Unknown Author"
                dateLabel.text = article.publishedAt
                descriptionTextView.text = article.content ?? "Content Unavailable. Go to the news source."
            }
        }
    }
    
    @IBAction func sourceButtonAction(_ sender: Any) {
        
    }
}

extension DetailViewController: DetailViewModelOutputProtocol {
    func update() {
        print("Update")
    }
    
    func error() {
        print("Error")
    }
}
