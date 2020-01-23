//
//  FindBeerContract.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

enum BeerInteractorError {
    case networkError(error: BeerNetworkServiceError)
}
enum BeerInteractorResponse {
    case succeed(models: [Beer])
    case failure(error: BeerInteractorError)
}

protocol FindBeerViewContract {
    func configure(with viewModel: FindBeerViewModel)
    func setNoResultsView(addView: Bool)
    func vc() -> FindBeerView
}

protocol FindBeerInteractorContract {    
    func getBeerWith(request: RequestBy, completion: @escaping ((BeerInteractorResponse) -> ()))
}

protocol FindBeerPresenterContract {
    func viewDidLoad()
    func reconfigureView()
    func getNumberOfModels() -> Int
    func getModels() -> [Beer]
    func getModel(for indexPath: IndexPath) -> Beer
    func changeSortBy()
    func newRequest(with text: String)
}
protocol FindBeerWireframeContract {
    func showError(description: String, completion: (() -> Void)?)
    func showLoading()
    func hideLoading()
}
