//
//  ResponseHandler.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import Foundation

struct ResponseHandler {
    
    var customJsonDecoder : JSONDecoder? = nil
    
    private func createJsonDecoder() -> JSONDecoder {
        let decoder =  customJsonDecoder != nil ? customJsonDecoder! : JSONDecoder()
        if customJsonDecoder == nil {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type, completionHandler: @escaping (Result<T?, ParseError>) -> Void) {
        let decoder = createJsonDecoder()
        do {
            let response = try decoder.decode(responseType, from: data)
            completionHandler(.success(response))
        } catch let error {
            debugPrint("error while decoding JSON response =>\(error.localizedDescription)")
            completionHandler(.failure(ParseError(withResponse: data, errorMessage: error.localizedDescription)))
        }
    }
}
