//
//  UserInfoVC.swift
//  GHLookup
//
//  Created by JJ on 21/05/24.
//

import UIKit

class UserInfoVC: UIViewController {

    //MARK: - properties
    var username: String!
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(username)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    
    //MARK: - helpers
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
