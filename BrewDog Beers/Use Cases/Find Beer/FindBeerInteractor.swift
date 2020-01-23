//
//  FindBeerInteractor.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation


enum RequestBy {
    case beer(String)
    case food(String)
}

/// This struct packages the URL transformation needed
private struct BeerInteractorPaginatedRequest{
    
    /// Whether the list has been exahusted or not
    var exhausted = false
    
    var page: URLRequest
    
    init(name: RequestBy) {
        var url: String = "https://\(Config.shared.host)"
        var params: [String:String] = [:]
        url += "/v2/beers"
        
        switch name {
        case .beer(let beerName):
            params["beer_name"] = beerName
        case .food(let foodName):
            params["food"] = foodName
        }
        
        var components = URLComponents.init(url: URL.init(string: url)!, resolvingAgainstBaseURL: true)!
        components.queryItems = params.map { (key, value) in
            URLQueryItem.init(name: key, value: value)
        }
        
        page = URLRequest.init(url: components.url!)
    }
}

class FindBeerInteractor: FindBeerInteractorContract {
    // MARK: - Vars
    var presenter: FindBeerPresenterContract?
    
    private let networkService: BeerNetworkServiceProtocol
    private let cachingService: NetworkCachingServiceProtocol
    
    // MARK: - Lifecycle
    init(networkService: BeerNetworkServiceProtocol,
         cachingService: NetworkCachingServiceProtocol) {
        self.networkService = networkService
        self.cachingService = cachingService
    }

    // MARK: - Contract
    func getBeerWith(request: RequestBy, completion: @escaping ((BeerInteractorResponse) -> ())) {
        let request = BeerInteractorPaginatedRequest.init(name: request)
        self.cachingService.getCacheObject(for: request.page.url!) { (cachedResponse:NetworkCachingStruct<[Beer]>?) in

            guard cachedResponse == nil else {
                let cached = cachedResponse!
                DispatchQueue.main.async {
                    completion(.succeed(models: cached.data))
                }
                return
            }
        
            self.networkService.getBeersPage(request: request.page, completion: { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(error: .networkError(error: error)))
                case .succeed(let models):
                    self.cachingService.setCache(url: request.page.url!,
                                     data: NetworkCachingStruct(data: models))

                    completion(.succeed(models: models))
                }
            })
        }
    }
}
