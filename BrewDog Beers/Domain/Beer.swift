//
//  Beer.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/// Domain model for beers
struct Beer: Codable {

    var id: Int
    var name: String
    var tagline: String
    var description: String
    var imagePath: String
    var abv: Double
    
    init(id: Int = -1,
         name: String,
         tagline: String,
         description: String,
         imagePath: String,
         abv: Double) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.description = description
        self.imagePath = imagePath
        self.abv = abv
    }
}

extension Beer: Validate {
    func isValid() -> Bool {
        return -1 != self.id
    }
}


extension Beer: Hashable, DictionaryTransformable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        guard let lhd = lhs.toDictionary(), let rhd = rhs.toDictionary() else { return true }
        return NSDictionary(dictionary: lhd).isEqual(to:rhd)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
