//
//  JSONUtility.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

struct JSONUtility {
    
    func requestData(from request: JSONRequest, completionHandler: @escaping (Result<Data, JSONError>) -> Void) {
        guard let path = Bundle.main.path(forResource: request.fileName, ofType: request.fileType) else {
            completionHandler(.failure(JSONError(forFileName: "\(request.fileName).\(request.fileType)", errorMessage: "File not found")))
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            completionHandler(.success(data))
        } catch {
            debugPrint(error)
            completionHandler(.failure(JSONError(forFileName: "\(request.fileName).\(request.fileType)", errorMessage: error.localizedDescription)))
        }
    }
}
