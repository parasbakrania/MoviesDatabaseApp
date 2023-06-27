//
//  JSONError.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

class JSONError: CommonError {
    var responseData: String?
    var requestFileName: String?

    init(withResponse response: Data? = nil, forFileName name: String, errorMessage message: String) {
        super.init(errorMessage: message)
        self.responseData = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestFileName = name
    }
}
