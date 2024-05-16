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
    
    //Put this network call here instead of the NetworkManager cuz dont have to handle errors since there is a placeholder image for avatar images
    
    func downloadImage(from urlString:String){
        //If image exists in cache get image from cache and DONT run the network calls
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        //If image not found in cache make network call to get the image
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response else {return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            //Save the image to the cache
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume() 
    }
}
