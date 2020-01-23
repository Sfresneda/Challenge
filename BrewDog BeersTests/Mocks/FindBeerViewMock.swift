//
//  FindBeerViewMock.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import BrewDog_Beers

class FindBeerViewMock: FindBeerViewContract {
    var viewModel: FindBeerViewModelProtocol?
    var presenter: FindBeerPresenterContract?

    var spyConfigure: Bool = false
    var spyNoResultsView: Bool = false
    var spyVC: Bool = false
    
    func configure(with viewModel: FindBeerViewModel) {
        self.spyConfigure = true
    }
    
    func setNoResultsView(addView: Bool) {
        self.spyNoResultsView = true
    }
    
    func vc() -> FindBeerView {
        self.spyVC = true
        return FindBeerView.init()
    }
}
