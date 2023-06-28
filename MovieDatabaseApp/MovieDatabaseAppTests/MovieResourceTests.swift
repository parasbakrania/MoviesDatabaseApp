//
//  MovieResourceTests.swift
//  MovieDatabaseAppTests
//
//  Created by AdminFS on 28/06/23.
//

import XCTest
@testable import MovieDatabaseApp

final class MovieResourceTests: XCTestCase {
    
    var movieResource: MovieResource!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let fileUtility = FileUtility()
        let responseDecoder = ResponseDecoder()
        responseDecoder.decoder = JSONDecoder()
        movieResource = MovieResource(dataUtility: fileUtility, responseHandler: responseDecoder)
    }

    override func tearDownWithError() throws {
        movieResource = nil
    }

    func testExample() throws {
        movieResource.getMovieCategoryDetails(type: .year, responseType: [Movie].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        movieResource.getMovieCategoryDetails(type: .genre, responseType: [Movie].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        movieResource.getMovieCategoryDetails(type: .directors, responseType: [Movie].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        movieResource.getMovieCategoryDetails(type: .actors, responseType: [Movie].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        movieResource.getMovieCategoryDetails(type: .allMovies, responseType: [Movie].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        movieResource.searchMovie(text: "") { result in
            switch result {
            case .success(let data):
                XCTAssertNoThrow(data)
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
