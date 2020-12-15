//
//  Photos.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

struct PhotosStorage {
   let imageNames: [Photo] = {
    var array: [Photo] = []
    for index in 1...20 {
      var imageName = "nudi\(index)"
      array.append(Photo(photo: UIImage(named: imageName)!))
    }
    return array
  }()
}

struct Photo {
  let photo: UIImage
}

