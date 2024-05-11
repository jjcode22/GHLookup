//
//  UIViewControllerExtension.swift
//  GHLookup
//
//  Created by JJ on 11/05/24.
//

import UIKit

extension UIViewController{
    func presentGHAlertOnMainThread(title: String,message: String,buttonTitle: String){
        DispatchQueue.main.async {
            let controller = GHAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true)
        }
    }
}
