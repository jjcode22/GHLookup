//
//  FollowerListVC.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

class FollowerListVC: UIViewController {
    //MARK: - properties
    var username: String?
    
    
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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        print("Username from FollowerListVC - \(username)")
        

        // Do any additional setup after loading the view.
    }
    //MARK: - helpers

}
