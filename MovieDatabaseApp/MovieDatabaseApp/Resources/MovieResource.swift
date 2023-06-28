//
//  MovieResource.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import Foundation

protocol MovieResourceProtocol {
    func getMoviesWith<T: Decodable>(request: Request, responseType: T.Type, completionHandler: @escaping(_ result: Result<T?, CommonError>) -> Void)
    
    func getMovieCategories() -> [MovieCategory]
    
    func getMovieCategoryDetails<T: Decodable>(type: MovieCategoryType, from movies: [Movie]?, responseType: T.Type, completionHandler: @escaping(_ result: Result<T?, CommonError>) -> Void)
    
    func searchMovie(text: String, movies: [Movie]?, completionHandler: @escaping(_ result: Result<[Movie]?, CommonError>) -> Void)
}

struct MovieResource: MovieResourceProtocol {
    
    private let dataUtility: DataUtilityProtocol
    private let responseHandler: ResponseHandlerProtocol
    
    init(container: DICProtocol) {
        self.dataUtility = container.resolve(type: DataUtilityProtocol.self) ?? FileUtility()
        self.responseHandler = container.resolve(type: ResponseHandlerProtocol.self) ?? ResponseDecoder(decoder: JSONDecoder())
    }
    
    func getMoviesWith<T: Decodable>(request: Request, responseType: T.Type, completionHandler: @escaping(_ result: Result<T?, CommonError>) -> Void) {
        self.dataUtility.requestData(from: request) { result in
            switch result {
            case .success(let data):
                self.responseHandler.decodeResponse(data: data, responseType: responseType) { result in
                    switch result {
                    case .success(let response):
                        completionHandler(.success(response))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func getMovieCategories() -> [MovieCategory] {
        let yearData = MovieCategory(type: .year)
        let genreData = MovieCategory(type: .genre)
        let directorsData = MovieCategory(type: .directors)
        let actorsData = MovieCategory(type: .actors)
        let allMoviesData = MovieCategory(type: .allMovies)
        return [yearData, genreData, directorsData, actorsData, allMoviesData]
    }
    
    func getMovieCategoryDetails<T: Decodable>(type: MovieCategoryType, from movies: [Movie]? = nil, responseType: T.Type, completionHandler: @escaping(_ result: Result<T?, CommonError>) -> Void) {
        switch type {
        case .year:
            let yearValues = Set(movies?.compactMap{ $0.year } ?? []).map { year in
                MovieCategoryDetail(title: year, movies: movies?.filter{ $0.year == year })
            } as? T
            completionHandler(.success(yearValues))
            
        case .genre:
            let genreValues = Set(movies?.compactMap{ $0.genre }.flatMap{ $0 } ?? []).map { genre in
                MovieCategoryDetail(title: genre, movies: movies?.filter{ $0.genre?.contains(genre) ?? false })
            } as? T
            completionHandler(.success(genreValues))
            
        case .directors:
            let directorValues = Set(movies?.compactMap{ $0.director }.flatMap{ $0 } ?? []).map { director in
                MovieCategoryDetail(title: director, movies: movies?.filter{ $0.director?.contains(director) ?? false })
            } as? T
            completionHandler(.success(directorValues))
            
        case .actors:
            let actorValues = Set(movies?.compactMap{ $0.actors }.flatMap{ $0 } ?? []).map { title in
                MovieCategoryDetail(title: title, movies: movies?.filter{ $0.actors?.contains(title) ?? false })
            } as? T
            completionHandler(.success(actorValues))
            
        case .allMovies:
            completionHandler(.success(movies as? T))
            
        }
    }
    
    func searchMovie(text: String, movies: [Movie]? = nil, completionHandler: @escaping(_ result: Result<[Movie]?, CommonError>) -> Void) {
        if text.isEmpty {
            completionHandler(.success(nil))
        } else {
            let searchedMovies = movies?.filter({ ($0.title?.localizedCaseInsensitiveContains(text) ?? false) || ($0.genre?.joined().localizedCaseInsensitiveContains(text) ?? false) || ($0.actors?.joined().localizedCaseInsensitiveContains(text) ?? false) || ($0.director?.joined().localizedCaseInsensitiveContains(text) ?? false) })
            completionHandler(.success(searchedMovies))
        }
    }
}

