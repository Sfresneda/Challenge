//
//  FindBeerTableViewCell.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/21/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class FindBeerTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageBeer: UIImageView!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Vars
    var viewModel: FindBeerTableViewModel?
    static var reuseViewIdentifier: String {
        return FindBeerTableViewCell.description()
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        self.abv.text = self.viewModel?.abv
        self.title.text = self.viewModel?.name
        self.subtitle.text = self.viewModel?.tagline
        self.descriptionLabel.text = self.viewModel?.description
        
        self.imageBeer?.contentMode = .scaleAspectFit
        self.imageBeer?.clipsToBounds = true
    }
    
    func setImage() {
        let url = URL.init(string: self.viewModel!.imagePath)!
        self.viewModel?.download(from: url, completion: { (data) in
            guard let imageData = data else { return }
            
            self.imageBeer?.image = UIImage.init(data: imageData)
        })
    }
    func cancelDownload() {
        self.viewModel?.cancelDownload()
    }
}
