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
    
    private lazy var heartButton: UIButton = {
        heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .systemGray
        heartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
      return heartButton
    }()
    
    var detailViewModel: DetailViewModelProtocol = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        sourceButtonConfiguration()
        heartButtonConfiguration()
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
    
}
//MARK: -ButtonConfiguration
extension DetailViewController {
    //MARK: -HeartButtonConfiguration
    func heartButtonConfiguration() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: heartButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func heartButtonTapped() {
        if heartButton.tintColor == .systemGray {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .systemGray
        }
    }
    //MARK: -SourceButtonConfiguration
    func sourceButtonConfiguration() {
        sourceButton.layer.cornerRadius = 5
        sourceButton.layer.borderWidth = 1
        sourceButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func sourceButtonAction(_ sender: Any) {
        
    }
}
//MARK: -DetailViewModelOutputProtocol
extension DetailViewController: DetailViewModelOutputProtocol {
    func update() {
        print("Update")
    }
    
    func error() {
        print("Error")
    }
}
