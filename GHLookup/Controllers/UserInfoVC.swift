//
//  UserInfoVC.swift
//  GHLookup
//
//  Created by JJ on 21/05/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
    
}


class UserInfoVC: UIViewController {
 
    //MARK: - properties
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHBodyLabel(textAlignment: .center)
    var itemViews:[UIView] = []
    
    weak var delegate: FollowerListVCDelegate!
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        loadUserData ()
        
    }

    
    //MARK: - helpers
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func loadUserData(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user:User){
        let repoItemVC = GHRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GHFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github user since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI(){
        itemViews  = [headerView,itemViewOne,itemViewTwo,dateLabel]
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
            ])
        }
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

//MARK: - UserInfoVCDelegate

extension UserInfoVC: UserInfoVCDelegate{
    func didTapGithubProfile(for user:User) {
        //Show safari view controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return}
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: User) {
        //dismissVC
        //Tell follower list screen the new user
        guard user.followers != 0 else {
            presentGHAlertOnMainThread(title: "No followers", message: "This user has no followers 😭", buttonTitle: "Ok")
            return}
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
