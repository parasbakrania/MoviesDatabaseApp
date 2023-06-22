//
//  WatchOption.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import Foundation

struct WatchOption {
    let type: WatchOptionType?
    let values: [WatchOptionValue]?
}

struct WatchOptionValue {
    let title: String?
    let movies: [Movie]?
}

enum WatchOptionType: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
}
