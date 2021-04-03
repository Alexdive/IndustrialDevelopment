//
//  PostViewModel.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/29/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

class PostViewModel {
    
    func fetchAndDecodeResidents(urlString: String, completion: @escaping ([String]?) -> Void) {
        NetworkService.fetchData(urlString: urlString) { data in
            
            let decoder = JSONDecoder()
            
            do {
                let planet = try decoder.decode(PlanetModel.self, from: data)
                completion(planet.residents)

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAndGetResidentName(urlString: String, completion: @escaping (String?) -> Void) {
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
}
