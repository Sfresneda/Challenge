//
//  Constants.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

enum UseCases {
    case findBeer
    
    var viewController: UIViewController {
        switch self {
        case .findBeer:
            return FindBeerBuilder.build()
        }
    }
}
