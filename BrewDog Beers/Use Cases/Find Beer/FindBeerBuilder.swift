//
//  FindBeerBuilder.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class FindBeerBuilder {
    static func build() -> UIViewController {
        let networkService = BeerNetworkService(networkingManager: NetworkManager.shared)

        let view = FindBeerView.init()
        let interactor = FindBeerInteractor.init(networkService: networkService, cachingService: NetworkCachingService.shared)
        let presenter = FindBeerPresenter.init()
        let entity = FindBeerEntity.init()
        let wireframe = FindBeerWireframe.init()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.entity = entity
        presenter.wireframe = wireframe
        
        wireframe.view = view
        wireframe.presenter = presenter
        
        return view
    }
    
}
