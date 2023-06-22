//
//  MovieInfo.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import Foundation

struct MovieInfo {
    let type: MovieInfoType?
    let values: Any?
}

enum MovieInfoType: String {
    case plot = "Plot"
    case castnCrew = "Cast & Crew"
    case releasedDate = "Released Date"
    case genre = "Genre"
    case rating = "Rating"
}
