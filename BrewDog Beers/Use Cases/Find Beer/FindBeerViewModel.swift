//
//  FindBeerViewModel.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/21/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol FindBeerViewModelDelegate {
    func cellIsPressed(at indexPath: IndexPath)
}

protocol FindBeerViewModelProtocol: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var delegate: FindBeerViewModelDelegate? { get set }
}

class FindBeerViewModel: NSObject {
    private let beers: [FindBeerTableViewModel]
    var delegate: FindBeerViewModelDelegate?
    
    init(beers: [Beer]) {
        self.beers = beers.map{ FindBeerTableViewModel.init(model: $0) }
    }
}

extension FindBeerViewModel: FindBeerViewModelProtocol {
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FindBeerTableViewCell = tableView
            .dequeueReusableCell(withIdentifier: FindBeerTableViewCell.reuseViewIdentifier) as? FindBeerTableViewCell else {
                return UITableViewCell.init()
        }
        cell.viewModel = self.beers[indexPath.row]
        cell.accessibilityIdentifier = "cell_\(indexPath.row)"
        cell.setup()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.cellIsPressed(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let beerCell = cell as? FindBeerTableViewCell else { return }
        beerCell.setImage()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let beerCell = cell as? FindBeerTableViewCell else { return }
        beerCell.cancelDownload()
    }
}

