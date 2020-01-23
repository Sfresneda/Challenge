//
//  FindBeerTableViewModel.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/21/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

protocol FindBeerTableViewModelProtocol {
    func downloaded(from url: URL, completion: ((Data?) ->()))
    func cancelDownload()
}

class FindBeerTableViewModel {
    
    let donwloadSession: URLSession = URLSession.shared
    
    let imagePath: String
    let name: String
    let tagline: String
    let description: String
    let abv: String
    
    init(model: Beer) {
        self.imagePath = model.imagePath
        self.name = model.name
        self.tagline = model.tagline
        self.description = model.description
        self.abv = "\(model.abv) %"
    }
}

extension FindBeerTableViewModel {
    func download(from url: URL, completion: @escaping ((Data?) ->())) {
        
        self.donwloadSession.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                200 == httpURLResponse.statusCode,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                nil == error else {
                    completion(nil)
                    return
            }
                        
            DispatchQueue.main.async {
                completion(data)
            }
            
        }.resume()
    }
    
    func cancelDownload() {
        self.donwloadSession.invalidateAndCancel()
    }
}
