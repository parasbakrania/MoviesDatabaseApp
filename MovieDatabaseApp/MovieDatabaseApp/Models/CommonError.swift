//
//  CommonError.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

class CommonError: Error {
    var reason: String?
    
    init(errorMessage message: String) {
        self.reason = message
    }
}
