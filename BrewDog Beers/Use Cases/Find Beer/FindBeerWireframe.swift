//
//  FindBeerWireframe.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

class FindBeerWireframe: BaseWireframe, FindBeerWireframeContract {
    // MARK: - Vars
    var view: FindBeerViewContract?
    var presenter: FindBeerPresenterContract?
    
    // MARK: - Contract    
    func showError(description: String, completion: (() -> Void)?) {
        self.showBasicErrorAlert(self.view?.vc(),
                                 content: description,
                                 completion: nil)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view?.vc().showLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view?.vc().hideLoading()
        }
    }
}
