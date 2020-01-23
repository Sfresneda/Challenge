//
//  DictionaryTransformable.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/// Protocol to allow dictionary transformation of a codable
protocol DictionaryTransformable: Codable {
    func toDictionary() -> [String: Any]?
}

/// Helper to make codable show json dicts
extension DictionaryTransformable {
    func toDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let jsonData = try? encoder.encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: [.mutableContainers]),
            let jsonDict = json as? [String: Any] else {
                return nil
        }
        return jsonDict
    }
}

