//
//  NetworkCachingServiceMock.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import BrewDog_Beers

class NetworkCachingServiceMock: NetworkCachingServiceProtocol {
    var spyResult: Bool = false
    var stubResult: ((NetworkCachingStruct<[Beer]>?) -> ())?
    
    func setCache<T>(url: URL, data: NetworkCachingStruct<T>) where T : Encodable { }
    
    func clearCache() { }
    
    func getCacheObject<T>(for url: URL, completion: @escaping ((NetworkCachingStruct<T>?) -> ())) where T : Decodable {
        self.spyResult = true
        self.stubResult = (completion as! ((NetworkCachingStruct<[Beer]>?) -> Void))
    }
}
