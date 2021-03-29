//
//  UserModel.swift
//  Navigation
//
//  Created by Alex Permiakov on 3/29/21.
//  Copyright © 2021 Alex Permiakov. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
