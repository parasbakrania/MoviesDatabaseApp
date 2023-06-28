//
//  ResponseDecoderTests.swift
//  MovieDatabaseAppTests
//
//  Created by AdminFS on 28/06/23.
//

import XCTest
@testable import MovieDatabaseApp

final class ResponseDecoderTests: XCTestCase {
    
    var responseDecoder: ResponseDecoder!
    
    override func setUpWithError() throws {
        let decoder = JSONDecoder()
        responseDecoder = ResponseDecoder()
        responseDecoder.configure(configuration: ResponseDecoder.ResponseDecoderConfiguration(decoder: decoder))
    }
    
    override func tearDownWithError() throws {
        responseDecoder = nil
    }
    
    func testExample() throws {
        let data = """
        [{
            "Title": "Meet the Parents",
            "Year": "2000",
            "Rated": "PG-13",
            "Released": "06 Oct 2000",
            "Runtime": "108 min",
            "Genre": "Comedy, Romance",
            "Director": "Jay Roach",
            "Writer": "Greg Glienna, Mary Ruth Clarke, Greg Glienna (story), Mary Ruth Clarke (story), Jim Herzfeld (screenplay), John Hamburg (screenplay)",
            "Actors": "Robert De Niro, Ben Stiller, Teri Polo, Blythe Danner",
            "Plot": "A Jewish male nurse plans to ask his live-in girl friend to marry him. However, he learns that her strict father expects to be asked for his daughter's hand before she can accept. Thus begins the visit from Hell as the two travel to meet Mom and Dad, who turns out to be former CIA with a lie detector in the basement. Coincidentally, a sister also has announced her wedding to a young doctor. Of course everything that can go wrong, does, including the disappearance of Dad's beloved Himalayan cat, Jinxie.",
            "Language": "English, Thai, Spanish, Hebrew, French",
            "Country": "USA",
            "Awards": "Nominated for 1 Oscar. Another 7 wins & 14 nominations.",
            "Poster": "https://m.media-amazon.com/images/M/MV5BMGNlMGZiMmUtZjU0NC00MWU4LWI0YTgtYzdlNGVhZGU4NWZlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
            "Ratings": [{
                "Source": "Internet Movie Database",
                "Value": "7.0/10"
            }, {
                "Source": "Rotten Tomatoes",
                "Value": "84%"
            }, {
                "Source": "Metacritic",
                "Value": "73/100"
            }],
            "Metascore": "73",
            "imdbRating": "7.0",
            "imdbVotes": "310,464",
            "imdbID": "tt0212338",
            "Type": "movie",
            "DVD": "N/A",
            "BoxOffice": "$166,244,045",
            "Production": "Nancy Tenenbaum Productions, Universal Pictures, Tribeca Productions, DreamWorks Pictures",
            "Website": "N/A",
            "Response": "True"
        }]
        """.data(using: .utf8)
        responseDecoder.decodeResponse(data: data!, responseType: [Movie].self) { result in
            switch result {
            case .success(let movies):
                XCTAssertNoThrow(movies)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
