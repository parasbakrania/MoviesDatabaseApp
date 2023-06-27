//
//  MovieCategory.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

struct MovieCategory {
    let type: MovieCategoryType?
    var values: Any?
}

struct MovieCategoryDetail {
    let title: String?
    let movies: [Movie]?
}

enum MovieCategoryType: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
}
