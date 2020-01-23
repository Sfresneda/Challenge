//
//  FindBeerInteractorMock.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

@testable import BrewDog_Beers

class FindBeerInteractorMock: FindBeerInteractorContract {
    var presenter: FindBeerPresenterContract?

    var spyDoPerformGetBeers = false
    var stubDoPerformGetBeersCompletion: ((BeerInteractorResponse) -> ())?
    
    func getBeerWith(request: RequestBy, completion: @escaping ((BeerInteractorResponse) -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.spyDoPerformGetBeers = true
            self.stubDoPerformGetBeersCompletion = completion
        }
    }
}
