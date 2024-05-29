//
//  NetworkManager.swift
//  GHLookup
//
//  Created by JJ on 11/05/24.
//

import UIKit

class NetworkManager{
    //network manager singleton 1) create a shared object with an instance of singleton class and make it static
    //static keyword makes sure every networkmanager has the shared property. i.e each instance share the same value. They don't have their own copy of the shared property. One shared property is common for all networkmanagers
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    //create an NSCache for caching images to save API calls
    let cache = NSCache<NSString,UIImage>()
    
    //make the init method private
    private init( ){
        
    }
    
    func getFollowers(for username: String,page: Int, completion: @escaping(Result<[Follower],GHError>) -> Void){
        let urlString = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUsername))
            return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return}
            guard let data = data else {
                completion(.failure(.invalidData))
                return}
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }catch{
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
    func getUserInfo(for username: String , completion: @escaping(Result<User,GHError>) -> Void){
        let urlString = "\(baseURL)\(username)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUsername))
            return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return}
            guard let data = data else {
                completion(.failure(.invalidData))
                return}
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            }catch{
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
    //Func signature not using result type cuz dont have to handle errors since there is a placeholder image for avatar images
    func downloadImage(from urlString:String,completion: @escaping(UIImage?) -> Void){
        //If image exists in cache get image from cache and DONT run the network calls
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        //If image not found in cache make network call to get the image
        guard let url = URL(string: urlString) else {
            completion(nil)
            return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) 
            else{
                completion(nil)
                return
            }
            
            //Save the image to the cache
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }

}
