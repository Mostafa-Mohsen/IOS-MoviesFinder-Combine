//
//  MovieCell.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        titleLabel.text = ""
    }
    
    func configure(with model: Movie) {
        titleLabel.text = model.title
        movieImage.downloadImage(with: model.poster)
    }
}
