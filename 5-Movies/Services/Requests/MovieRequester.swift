//
//  MovieRequester.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import Combine

class MovieRequester {
    let webService: WebService
    let url = "https://www.omdbapi.com/"
    let apiKey = "apikey=564727fa"
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func getMovies(name: String) -> AnyPublisher<MoviesEntity?, NetworkError> {
        let url = url + "?s=\(name)&" + apiKey
        return webService.request(urlPath: url)
            .map{ (data) -> MoviesEntity? in
                guard let unwrappedData = data, let attributes = unwrappedData as? [String: AnyObject] else {
                    return nil
                }
                return MoviesEntity(attributes)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
