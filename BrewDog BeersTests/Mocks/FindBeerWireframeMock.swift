//
//  FindBeerWireframeMock.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

@testable import BrewDog_Beers

class FindBeerWireframeMock: FindBeerWireframeContract {
    var view: FindBeerViewContract?
    var presenter: FindBeerPresenterContract?

    var spyShowError: Bool = false
    var spyShowLoading: Bool = false
    var spyHideLoading: Bool = false
    
    func showError(description: String, completion: (() -> Void)?) {
        self.spyShowError = true
    }
    func showLoading() {
        self.spyShowLoading = true
    }
    func hideLoading() {
        self.spyHideLoading = true
        debugPrint("hideLoading \(self.spyHideLoading)")
    }
}
