//
//  FindBeerPresenter.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

class FindBeerPresenter: FindBeerPresenterContract {
    
    // MARK: - Vars
    var view: FindBeerViewContract?
    var interactor: FindBeerInteractorContract?
    var entity: FindBeerEntity?
    var wireframe: FindBeerWireframeContract?
    
    // MARK: - Contract
    func viewDidLoad() {
        self.reconfigureView()
    }
    
    func reconfigureView() {
        self.view?.configure(with:
            FindBeerViewModel.init(beers: self.getModels())
        )
    }
    
    func getModels() -> [Beer] {
        guard let wrappedEntity = self.entity else { return []}
        return self.sort(models: wrappedEntity.beers,
                         orderBy: wrappedEntity.resultsSort)
    }
    
    func getModel(for indexPath: IndexPath) -> Beer {
        return self.getModels()[indexPath.row]
    }
    
    func getNumberOfModels() -> Int {
        return self.entity?.beers.count ?? 0
    }
    
    func changeSortBy() {
        self.entity?.resultsSort = self.entity?.resultsSort == OrderBy.asc ? .desc : .asc
        self.reconfigureView()
    }
    
    func newRequest(with text: String) {
        let sanitizedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "_")
        
        guard sanitizedText.count > 0 else {
            
            return
        }
        
        let operation = BlockOperation()
        self.entity?.cancelAllOperations()
        operation.addExecutionBlock {
            Thread.sleep(forTimeInterval: 0.2)
            self.wireframe?.showLoading()
            guard !operation.isCancelled else { return }
            self.interactor?.getBeerWith(request: .food(sanitizedText), completion: { (result) in
                switch result {
                case .failure(let error):
                    self.wireframe?.showError(description: "Error: \(error)", completion: nil)
                    self.entity?.beers.removeAll()
                    
                case .succeed(let models):
                    self.entity?.beers = models
                }
                
                self.view?.setNoResultsView(addView: self.getModels().isEmpty)
                self.wireframe?.hideLoading()
                self.reconfigureView()
            })
        }
        self.entity?.addSearchOperation(operation: operation)
    }
    
    // MARK: - Helper
    private func sort(models: [Beer], orderBy: OrderBy = .asc) -> [Beer]  {
        return models.sorted {
            (el1, el2) -> Bool in
            orderBy == .asc ?
                el1.abv < el2.abv:
                el1.abv > el2.abv
        }
    }
}
