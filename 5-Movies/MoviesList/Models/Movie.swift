//
//  Movie.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
enum MoviesKeys: String {
    case SearchKey = "Search"
    case TitleKey = "Title"
    case ImdbIDKey = "imdbID"
    case TypeKey = "Type"
    case PosterKey = "Poster"
}

struct MoviesEntity {
    let movies: [Movie]
    
    init(_ attributes: [String: AnyObject]) {
        movies = MoviesEntity.getMovies(attributes)
    }
    
    private static func getMovies(_ attributes: [String: AnyObject]) -> [Movie] {
        let moviesAttributes = attributes[MoviesKeys.SearchKey.rawValue] as? [[String: AnyObject]] ?? []
        return moviesAttributes.map { Movie($0) }
    }
}

struct Movie {
    let title: String
    let imdbID: String
    let type: String
    let poster: String
    
    init(_ attributes: [String: AnyObject]) {
        title = attributes[MoviesKeys.TitleKey.rawValue] as? String ?? ""
        imdbID = attributes[MoviesKeys.ImdbIDKey.rawValue] as? String ?? ""
        type = attributes[MoviesKeys.TypeKey.rawValue] as? String ?? ""
        poster = attributes[MoviesKeys.PosterKey.rawValue] as? String ?? ""
    }
}
