//
//  GHAvatarImageView.swift
//  GHLookup
//
//  Created by JJ on 13/05/24.
//

import UIKit

class GHAvatarImageView: UIImageView {
    //MARK: - properties
    let placeholderImage = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
    private func configure(){
        layer.cornerRadius = 16
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
