//
//  NetworkManager.swift
//  GHLookup
//
//  Created by JJ on 11/05/24.
//

import Foundation

class NetworkManager{
    //network manager singleton 1) create a shared object with an instance of singleton class and make it static
    //static keyword makes sure every networkmanager has the shared property. i.e each instance share the same value. They don't have their own copy of the shared property. One shared property is common for all networkmanagers
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    //make the init method private
    private init( ){
        
    }
    
    func getFollowers(for username: String,page: Int, completion: @escaping([Follower]?,String?) -> Void){
        let urlString = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, "This username created an invalid request. Please try again")
            return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil,"Unable to complete your request. Please check your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,"Invalid response from the server. Please try again.")
                return}
            guard let data = data else {
                completion(nil,"The data received from the server was invalid. Please try again.")
                return}
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers,nil)
            }catch{
                completion(nil,"The data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume()
        
    }
}
