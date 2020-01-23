//
//  Validate.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/// This protocol checks if an object is valid or has default invalid values
protocol Validate {
    /// Whether the object is valid or has invalid values
    func isValid() -> Bool
}
