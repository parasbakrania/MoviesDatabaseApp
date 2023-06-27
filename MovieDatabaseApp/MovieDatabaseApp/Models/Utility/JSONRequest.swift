//
//  JSONRequest.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

struct JSONRequest {
    let fileName: String
    let fileType: String

    init(withFileName fileName: String, and fileType: String) {
        self.fileName = fileName
        self.fileType = fileType
    }
}
