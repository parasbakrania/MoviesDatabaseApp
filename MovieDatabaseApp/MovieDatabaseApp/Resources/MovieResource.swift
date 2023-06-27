//
//  MovieResource.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import Foundation

struct MovieResource {
    
    let jsonUtility: JSONUtility
    let responseHandler: ResponseHandler
    
    init(jsonUtility: JSONUtility, responseHandler: ResponseHandler) {
        self.jsonUtility = jsonUtility
        self.responseHandler = responseHandler
    }
    
    func getMoviesWith<T: Decodable>(request: JSONRequest, responseType: T.Type, completionHandler: @escaping(_ result: Result<T?, CommonError>) -> Void) {
        self.jsonUtility.requestData(from: request) { result in
            switch result {
            case .success(let data):
                self.responseHandler.decodeJsonResponse(data: data, responseType: responseType) { result in
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
    
    func getMovieCategoryDetails(type: MovieCategoryType, from movies: [Movie]) -> [Any] {
        switch type {
        case .year:
            return Set(movies.compactMap{ $0.year }).map { year in
                MovieCategoryDetail(title: year, movies: movies.filter{ $0.year == year })
            }
            
        case .genre:
            return Set(movies.compactMap{ $0.genre }.flatMap{ $0 }).map { genre in
                MovieCategoryDetail(title: genre, movies: movies.filter{ $0.genre?.contains(genre) ?? false })
            }
            
        case .directors:
            return Set(movies.compactMap{ $0.director }.flatMap{ $0 }).map { director in
                MovieCategoryDetail(title: director, movies: movies.filter{ $0.director?.contains(director) ?? false })
            }
            
        case .actors:
            return Set(movies.compactMap{ $0.actors }.flatMap{ $0 }).map { title in
                MovieCategoryDetail(title: title, movies: movies.filter{ $0.actors?.contains(title) ?? false })
            }
        
        case .allMovies:
            return movies
        }
    }
    
    func searchMovie(text: String, movies: [Movie], completionHandler: @escaping(_ result: Result<[Movie]?, CommonError>) -> Void) {
        if text.isEmpty {
            completionHandler(.success(nil))
        } else {
            let searchedMovies = movies.filter({ ($0.title?.localizedCaseInsensitiveContains(text) ?? false) || ($0.genre?.joined().localizedCaseInsensitiveContains(text) ?? false) || ($0.actors?.joined().localizedCaseInsensitiveContains(text) ?? false) || ($0.director?.joined().localizedCaseInsensitiveContains(text) ?? false) })
            completionHandler(.success(searchedMovies))
        }
    }
}

