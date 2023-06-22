//
//  MovieResource.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import Foundation

struct MovieResource {
    
    func getMovies(fileName: String, fileType: String, completionHandler: @escaping (_ result: [Movie]?) -> Void) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode([Movie].self, from: data)
            _ = completionHandler(response)
        } catch {
            debugPrint(error)
        }
    }
    
    func getWatchOptions(from movies: [Movie]) -> [WatchOption] {
        let yearValues = Set(movies.compactMap{ $0.year }).map { year in
            WatchOptionValue(title: year, movies: movies.filter{ $0.year == year })
        }
        let genreValues = Set(movies.compactMap{ $0.genre }.flatMap{ $0 }).map { genre in
            WatchOptionValue(title: genre, movies: movies.filter{ $0.genre?.contains(genre) ?? false })
        }
        let directorValues = Set(movies.compactMap{ $0.director }.flatMap{ $0 }).map { director in
            WatchOptionValue(title: director, movies: movies.filter{ $0.director?.contains(director) ?? false })
        }
        let actorValues = Set(movies.compactMap{ $0.actors }.flatMap{ $0 }).map { title in
            WatchOptionValue(title: title, movies: movies.filter{ $0.actors?.contains(title) ?? false })
        }
        let yearData = WatchOption(type: .year, values: yearValues)
        let genreData = WatchOption(type: .genre, values: genreValues)
        let directorsData = WatchOption(type: .directors, values: directorValues)
        let actorsData = WatchOption(type: .actors, values: actorValues)
        return [yearData, genreData, directorsData, actorsData]
    }
}

