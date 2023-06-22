//
//  Movie.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import Foundation

// MARK: - Movie
struct Movie: Decodable {
    let title, year, rated, released: String?
    let runtime, writer: String?
    @ArrayOfString var genre: [String]?
    @ArrayOfString var actors: [String]?
    @ArrayOfString var director: [String]?
    let plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type: TypeEnum?
    let dvd: String?
    let boxOffice, production: String?
    let website: String?
    let response: String?
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }
}

enum TypeEnum: String, Decodable {
    case movie = "movie"
    case series = "series"
}


@propertyWrapper
struct ArrayOfString {
  let wrappedValue: [String]?
}

extension ArrayOfString: Decodable {
  init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if let stringValue = try? container.decode(String.self) {
          self.wrappedValue = stringValue.components(separatedBy: ", ")
      } else {
          self.wrappedValue = try container.decode([String].self)
      }
  }
}
