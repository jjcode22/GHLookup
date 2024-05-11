//
//  FollowerListVC.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

class FollowerListVC: UIViewController {
    //MARK: - properties
    var username: String!
    
    
    //MARK: - lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        print("Username from FollowerListVC - \(username ?? "default")")
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else{
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: - helpers

}
