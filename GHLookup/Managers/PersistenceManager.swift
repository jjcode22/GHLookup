//
//  PersistenceManager.swift
//  GHLookup
//
//  Created by JJ on 24/05/24.
//

import Foundation

enum PersistenceActionType {
    case add,remove
}

enum PersistenceManager{
    static private let defaults = UserDefaults.standard
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower,actionType: PersistenceActionType, completion:  @escaping (GHError?) -> Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return}
                    retrievedFavorites.append(favorite)
                case .remove:
                    //remove from favorites where predicate login id matches
                    retrievedFavorites.removeAll {$0.login == favorite.login}
                }
                completion(save(favorites: retrievedFavorites))
            case .failure(let error):
                completion(error)
            }
        }
        
        
    }
    
    
    //when saving a custom object to userdefaults you have to encode it. for regular types no decoding needed.
    static func retrieveFavorites(completion: @escaping(Result<[Follower],GHError>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return}
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        }catch{
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GHError?{
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .invalidData
        }
    }
}
