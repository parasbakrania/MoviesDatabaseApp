//
//  FileRequest.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 28/06/23.
//

import Foundation

protocol Request {
    var url: URL? { get set }
}

struct FileRequest: Request {
    var url: URL?
    let fileName: String
    let fileType: String

    init(withFileName fileName: String, and fileType: String) {
        self.fileName = fileName
        self.fileType = fileType
    }
}
