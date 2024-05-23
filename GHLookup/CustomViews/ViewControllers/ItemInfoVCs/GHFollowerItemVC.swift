//
//  GHFollowerItemVC.swift
//  GHLookup
//
//  Created by JJ on 23/05/24.
//

import UIKit

class GHFollowerItemVC: GHItemInfoVC{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
        
    }
}
