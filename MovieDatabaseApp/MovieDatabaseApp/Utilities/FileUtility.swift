//
//  FileUtility.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 28/06/23.
//

import Foundation

protocol DataUtilityProtocol {
    func requestData(from request: Request, completionHandler: @escaping (Result<Data, CommonError>) -> Void)
}

struct FileUtility: DataUtilityProtocol {
    
    func requestData(from request: Request, completionHandler: @escaping (Result<Data, CommonError>) -> Void) {
        guard let request = request as? FileRequest else {
            completionHandler(.failure(CommonError(errorMessage: CommonString.noDataFound)))
            return
        }
        
        guard let path = Bundle.main.path(forResource: request.fileName, ofType: request.fileType) else {
            completionHandler(.failure(FileError(forFileName: "\(request.fileName).\(request.fileType)", errorMessage: CommonString.fileNotFound)))
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            completionHandler(.success(data))
        } catch {
            debugPrint(error)
            completionHandler(.failure(FileError(forFileName: "\(request.fileName).\(request.fileType)", errorMessage: error.localizedDescription)))
        }
    }
}

