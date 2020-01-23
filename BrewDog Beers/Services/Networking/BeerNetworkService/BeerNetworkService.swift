//
//  BeerNetworkService.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/// This struct packages the URL transformation needed
private struct BeerPaginateRequest {
    var page: URLRequest
    var exhausted: Bool = false
    
    
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

/**
This object will get the response from the server and return a suitable domain model
*/
struct BeerNetworkingServiceJSONResponse: Decodable {
    let id: Int
    let name: String
    let tagline: String?
    let description: String?
    let image_url: String?
    let imageData: Data?
    let abv: Double?
    
    /// This method transforms the response to the suitable model
    func toDomainModel() -> Beer {
        return Beer.init(
            id: id,
            name: name,
            tagline: tagline ?? "-",
            description: description ?? "-",
            imagePath: image_url ?? "-",
            abv: abv ?? 0.0)
    }
}

/// This class implements the BeerNetworkServiceProtocol
final class BeerNetworkService {
    private let networkingManager: NetworkWrapper
    
    init(networkingManager: NetworkManager) {
        self.networkingManager = networkingManager
    }
}

extension BeerNetworkService: BeerNetworkServiceProtocol {
    func getBeersPage(request: URLRequest, completion: @escaping ((BeerNetworkServiceResponse) -> ())) {
        self.networkingManager.get(request: request) { (response: NetworkWrapperResult<[BeerNetworkingServiceJSONResponse]>) in
            switch response {
            case .failed(let error):
                completion(.failure(error: .networkError(error: error)))
                
            case .succeed(let models):
                let domainModels = models.map({ $0.toDomainModel() })
                completion(.succeed(models: domainModels))
            }
        }
    }
}
