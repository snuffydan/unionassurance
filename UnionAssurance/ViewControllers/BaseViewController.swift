//
//  BaseViewController.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showActivityIndicator() {
        ActivityIndicator.start()
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.stop()
    }
    
    func isConnectedToInternet() -> Bool {
        do {
            let reachability = try Reachability()
            
            if reachability.connection == .unavailable {
                showNoNetworkAlert()
                return false
            } else {
                return true
            }
            
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func showNoNetworkAlert()
    {
        let alertController = UIAlertController (title: "Cellular Data is Turned Off", message: "Turn on cellular data or use Wi-Fi to access data.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
