//
//  CoreNetwork.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import Combine

class CoreNetwork {
    static var sharedInstance = CoreNetwork()
    
    private let webService = WebService()
    
    private init() {}
    
    func getMovies(name: String) -> AnyPublisher<MoviesEntity?, NetworkError> {
        let requester = MovieRequester(webService: webService)
        return requester.getMovies(name: name)
    }
}
