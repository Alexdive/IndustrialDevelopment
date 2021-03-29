//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/29/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

class ViewModel {
    
    func fetchAndDecodePlanetData(urlString: String, completion: @escaping (String?) -> Void) {
        NetworkService.fetchData(urlString: urlString) { data in
            
            let decoder = JSONDecoder()
            
            do {
                let planet = try decoder.decode(PlanetModel.self, from: data)
                completion(planet.orbitalPeriod)

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAndGetName(urlString: String, completion: @escaping (String?) -> Void) {
        NetworkService.fetchData(urlString: urlString) { data in
            
            let decoder = JSONDecoder()
            
            do {
                let char = try decoder.decode(SWCharacter.self, from: data)
                completion(char.name)

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAndSerializeData(completion: @escaping (String?) -> Void) {
        NetworkService.fetchData(urlString: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))") { data in
            if let dictionary = try? NetworkService.toObject(json: data) {
                let user = UserModel(
                    userID: dictionary["userId"] as! Int,
                    id: dictionary["id"] as! Int,
                    title: dictionary["title"] as! String,
                    completed: dictionary["completed"] as! Bool)
                completion(user.title)
            }
        }
    }
    
}
