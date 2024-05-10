//
//  SearchVC.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

class SearchVC: UIViewController {
    //MARK: -  properties
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints =  false
        iv.image = UIImage(named: "gh-logo")
        return iv
    }()
    
    let usernameTextField = GHTextField()
    let callToActionButton = GHButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    
    //MARK: -  lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCTAButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //called inside viewWillAppear as viewDidLoad is only called once so if pressed back the navigationbar will return after being hidden
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: -  helpers
    func configureLogoImageView(){
        //equivalent to dragging a view from menu to storyboard
        view.addSubview(logoImageView)
        //Use about 4 constraints mostly y anchor,x anchor,height,widht
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureCTAButton(){
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
