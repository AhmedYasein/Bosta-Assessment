//  Bosta Assessment
//  AlertManager.swift
//  Created by Ahmed Yasein on 03/12/2024.
//


import UIKit

class AlertManager {
    
    // Function to show an alert with a confirm button only
    static func showAlertWithButton(title: String, message: String, confirmTitle: String = "OK", confirmHandler: (() -> Void)? = nil) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        }
        alert.addAction(confirmAction)
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
    // Function to show an alert without buttons (auto-dismiss after a specified delay in seconds)
    static func showAlertWithoutButton(title: String, message: String, dismissDelay: TimeInterval = 2.0) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissDelay) {
            alert.dismiss(animated: true, completion: nil)
        }
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
