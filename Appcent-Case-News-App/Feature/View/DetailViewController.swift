//
//  DetailViewController.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 11.05.2024.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
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
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var detailViewModel: DetailViewModelProtocol = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        sourceButtonConfiguration()
        rightTopButtonConfiguration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
        isFavorite()
    }
    //FavoriteControl
    func isFavorite() {
        if let article = detailViewModel.article {
            if detailViewModel.isArticleFavorite(article) {
                heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                heartButton.tintColor = .red
            } else {
                heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                heartButton.tintColor = .systemGray
            }
        }
    }
}
//MARK: -ButtonConfiguration
extension DetailViewController {
    //MARK: -RightTopButtonConfiguration
    func rightTopButtonConfiguration() {
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        let shareBarButton = UIBarButtonItem(customView: shareButton)
        let heartBarButton = UIBarButtonItem(customView: heartButton)
        navigationItem.rightBarButtonItems = [heartBarButton, shareBarButton]
    }
    //MARK: -ShareButtonConfiguration
    @objc func shareButtonTapped() {
        guard let url = URL(string: detailViewModel.article?.url ?? "No URL") else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    //MARK: -HeartButtonConfiguration
    @objc func heartButtonTapped() {
        if heartButton.tintColor == .systemGray {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
            detailViewModel.saveToFavorites()
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .systemGray
            detailViewModel.removeFromFavorites()
        }
    }
    //MARK: -SourceButtonConfiguration
    func sourceButtonConfiguration() {
        sourceButton.layer.cornerRadius = 5
        sourceButton.layer.borderWidth = 1
        sourceButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func sourceButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sourceVC = storyboard.instantiateViewController(withIdentifier: "SourceViewController") as! SourceViewController
        if let articleUrl = detailViewModel.article?.url {
            sourceVC.sourceViewModel.articleUrl = URL(string: articleUrl)
        }
        navigationController?.pushViewController(sourceVC, animated: true)
    }
}

