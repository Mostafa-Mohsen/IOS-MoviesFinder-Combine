//
//  MoviesListViewModel.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import Combine

class MoviesListViewModel {
    var moviesPublisher = PassthroughSubject<[Movie], Never>()
    var movieDetailPublihser = PassthroughSubject<Movie, Never>()
    private var cancellable: AnyCancellable?
    
    func getMovies(name: String) {
        cancellable = CoreNetwork.sharedInstance.getMovies(name: name)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("success")
                case .failure(let error):
                    switch error {
                    case .error(let message):
                        print("error: \(message)")
                    }
                }
            }, receiveValue: { [weak self] movies in
                guard let weakSelf = self else { return }
                guard let unwrappedMovies = movies else { return }
                weakSelf.moviesPublisher.send(unwrappedMovies.movies)
            })
    }
    
    func didSelect(movie: Movie) {
        movieDetailPublihser.send(movie)
    }
}
