//
//  ReponseDecoder.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 28/06/23.
//

import Foundation

protocol ResponseHandler {
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type, completionHandler: @escaping (Result<T?, ParseError>) -> Void)
}

struct ReponseDecoder: ResponseHandler {
    
    var decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type, completionHandler: @escaping (Result<T?, ParseError>) -> Void) {
        do {
            let response = try decoder.decode(responseType, from: data)
            completionHandler(.success(response))
        } catch let error {
            debugPrint("error while decoding JSON response =>\(error.localizedDescription)")
            completionHandler(.failure(ParseError(withResponse: data, errorMessage: error.localizedDescription)))
        }
    }
}
