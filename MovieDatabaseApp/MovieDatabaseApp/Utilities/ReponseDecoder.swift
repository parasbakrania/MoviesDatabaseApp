//
//  ReponseDecoder.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 28/06/23.
//

import Foundation

protocol ResponseHandlerProtocol {
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type, completionHandler: @escaping (Result<T?, ParseError>) -> Void)
}

class ResponseDecoder: ResponseHandlerProtocol, Configurable {
    
    struct ResponseDecoderConfiguration {
        var decoder: JSONDecoder
    }
    
    var decoder: JSONDecoder?
    
    func configure(configuration: ResponseDecoderConfiguration) {
        self.decoder = configuration.decoder
    }
    
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type, completionHandler: @escaping (Result<T?, ParseError>) -> Void) {
        do {
            let response = try decoder?.decode(responseType, from: data)
            completionHandler(.success(response))
        } catch let error {
            debugPrint("error while decoding JSON response =>\(error.localizedDescription)")
            completionHandler(.failure(ParseError(withResponse: data, errorMessage: error.localizedDescription)))
        }
    }
}
