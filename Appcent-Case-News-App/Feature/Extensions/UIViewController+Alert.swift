//
//  UIViewController+Alert.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 13.05.2024.
//

import UIKit

extension UIViewController {
    /// Shows an alert with the specified title and message.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in}
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
