//
//  InfoDictionary.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

func InfoDictionary<T>(_ key: String, defaultValue: T? = nil) -> T where T: LosslessStringConvertible {
    let errorCompletion: () -> T = {
        guard let value = defaultValue else { fatalError("VALUE [\(key)] NOT FOUND") }
        return value
    }
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else { return errorCompletion() }
    switch object {
    case let value as T:
        return value
    case let valueString as String:
        guard let value = T(valueString) else { return errorCompletion() }
        return value
    default:
        return errorCompletion()
    }
}
