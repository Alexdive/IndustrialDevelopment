//
//  NetworkService.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/29/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static func fetchData(urlString: String?, completion: ((Data) -> Void)?) {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            
            
            URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                
                if let error = error as NSError? {
                    print("-------//------- \n" + error.localizedDescription)
                    print("-------//------- \n" + error.debugDescription)
                    
                    
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse {
                    print("-------//-------")
                    print(response.allHeaderFields)
                    print("-------//-------")
                    print(response.statusCode)
                    print("-------//-------")
                    print(String(data: data, encoding: .utf8)!)
                    
                    if let completion = completion {
                        completion(data)
                    }
                }
            }.resume()
        }
    }
}

extension NetworkService {
    static func toObject(json: Data) throws -> Dictionary<String, Any>? {
        return try JSONSerialization.jsonObject(
            with: json,
            options: .mutableContainers
        ) as? [String: Any]
    }
}
