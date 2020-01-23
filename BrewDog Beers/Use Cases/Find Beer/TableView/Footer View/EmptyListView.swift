//
//  EmptyListView.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class EmptyListView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    private func setupView() {
        self.title.text = "No Results"
        self.subtitle.text = "There were no results for this query. Try a new search."
    }
    
}
