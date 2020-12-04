//
//  Storage.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/12/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

struct Storage {
  static let posts: [Post] = [
    Post(author: "Alex",
         description: "Goby fish guarding its eggs on the wire coral.\nMore on https://instagram.com/alexphoto.pro",
         image: "goby",
         likes: 100,
         views: 200),
    Post(author: "Alex",
         description: "Juvenile warty frogfish striking a pose.\nMore on https://instagram.com/alexphoto.pro",
         image: "frogfish",
         likes: 122,
         views: 222),
    Post(author: "Alex",
         description: "Grouper on the cleaning station.\nMore on https://instagram.com/alexphoto.pro",
         image: "grouper",
         likes: 111,
         views: 333),
    Post(author: "Alex",
         description: "Coconut octopus shows off its glowing tentacles.\nMore on https://instagram.com/alexphoto.pro",
         image: "octopus",
         likes: 133,
         views: 444)
  ]
}


