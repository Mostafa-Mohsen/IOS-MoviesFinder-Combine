//
//  MovieDetailsViewController.swift
//  5-Movies
//
//  Created by M-M-M on 31/05/2023.
//

import Foundation
import UIKit
import SwiftUI

class MovieDetailsViewController: UIHostingController<MovieDetailsView> {
    
    static func getMovieDetailsViewController(with movie: Movie) -> UIViewController {
        let storyboard = UIStoryboard(name: "MovieDetailsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") { coder in
            return MovieDetailsViewController(coder: coder, movie: movie)
        }
        return vc
    }
    
    init?(coder aDecoder: NSCoder, movie: Movie) {
        let movieDetailView = MovieDetailsView(movie: movie)
        super.init(coder: aDecoder, rootView: movieDetailView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
