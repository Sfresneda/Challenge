//
//  Config.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

struct Config {
    static let shared = Config()
    
    let host: String = InfoDictionary("HOST")
    let defaultPageSize: Int = 10
    let defaultNetworkingTimeOut: TimeInterval = 60
    let bundleIdentifier: String = InfoDictionary("BUNDLE_IDENTIFIER", defaultValue: "")
    let appName: String = InfoDictionary("APP_NAME", defaultValue: "")
}
