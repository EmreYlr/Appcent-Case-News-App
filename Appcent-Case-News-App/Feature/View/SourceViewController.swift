//
//  SourceViewController.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 12.05.2024.
//

import UIKit
import WebKit

final class SourceViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet var webKitView: WKWebView!
    
    var sourceViewModel: SourceViewModelProtocol = SourceViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
    }
    
    func initLoad() {
        if let url = sourceViewModel.articleUrl {
            let myRequest = URLRequest(url: url)
            webKitView.load(myRequest)
        }else{
            showAlert(title: "Error", message: "Invalid url")
        }
    }
}
//MARK: -WKUIDelegate
extension SourceViewController: WKUIDelegate, WKNavigationDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webKitView = WKWebView(frame: .zero, configuration: webConfiguration)
        webKitView.uiDelegate = self
        webKitView.navigationDelegate = self
        view = webKitView
    }
}
