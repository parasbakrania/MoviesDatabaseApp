//
//  FileUtilityTests.swift
//  MovieDatabaseAppTests
//
//  Created by AdminFS on 28/06/23.
//

import XCTest
@testable import MovieDatabaseApp

final class FileUtilityTests: XCTestCase {
    
    var fileUtility: FileUtility!

    override func setUpWithError() throws {
        fileUtility = FileUtility()
    }

    override func tearDownWithError() throws {
        fileUtility = nil
    }

    func testExample() throws {
        let fileRequest = FileRequest(withFileName: ProjectImp.fileName, and: ProjectImp.fileType)
        fileUtility.requestData(from: fileRequest) { result in
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
