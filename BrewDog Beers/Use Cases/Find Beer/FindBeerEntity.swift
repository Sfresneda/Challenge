//
//  FindBeerEntity.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

enum OrderBy: String {
    case asc
    case desc
}

class FindBeerEntity {
    lazy var beers: [Beer] = []
    lazy var resultsSort: OrderBy = .asc
    
    private lazy var requestQueue: OperationQueue = {
        let queueOp = OperationQueue()
        queueOp.maxConcurrentOperationCount = 1
        return queueOp
    }()

    func addSearchOperation(operation: Operation) {
        self.requestQueue.addOperation(operation)
    }
    func cancelAllOperations() {
        self.requestQueue.cancelAllOperations()
    }
}
