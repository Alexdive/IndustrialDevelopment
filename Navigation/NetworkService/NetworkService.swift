//
//  NetworkService.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/29/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static func fetchData(urlString: String?, completion: ((String) -> Void)?) {
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
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let user = try decoder.decode(UserModel.self, from: data)
                        if let completion = completion {
                            completion(user.title)
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
            
        }
    }
}
