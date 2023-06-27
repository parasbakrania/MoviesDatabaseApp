//
//  MovieCategoriesVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import UIKit

class MovieCategoriesVC: UIViewController {
    
    @IBOutlet weak var tblVWMovieCategories: UITableView!
    
    private var movies: [Movie] = []
    private var movieCategories: [MovieCategory] = []
    
    private var movieResource: MovieResource?
    
    private var searchText = ""
    private var searchedMovies: [Movie] = []
    
    private var workItemReference : DispatchWorkItem? = nil
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUtility = JSONUtility()
        let responseHandler = ResponseHandler()
        movieResource = MovieResource(jsonUtility: jsonUtility, responseHandler: responseHandler)
        let jsonRequest = JSONRequest(withFileName: ProjectImp.fileName, and: ProjectImp.fileType)
        initializeData(from: movieResource, request: jsonRequest)
    }
    
    private func initializeData(from resource: MovieResource?, request: JSONRequest) {
        resource?.getMoviesWith(request: request, responseType: [Movie].self) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies ?? []
                self?.movieCategories = resource?.getMovieCategories() ?? []
                DispatchQueue.main.async {
                    self?.tblVWMovieCategories.reloadData()
                }
                
            case .failure(let error):
                debugPrint(error.reason ?? "")
                DispatchQueue.main.async {
                    self?.popupAlert(title: error.reason, message: nil, actionTitles: ["OK"], actions: [{_ in}])
                }
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToWatchOptionValuesVC(movieCategory: MovieCategory) {
        guard let movieCategoryDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.movieCategoryDetailsVC) as? MovieCategoryDetailsVC else { return }
        movieCategoryDetailsVC.movieCategoryTitle = movieCategory.type?.rawValue
        let resource = MovieResource(jsonUtility: JSONUtility(), responseHandler: ResponseHandler())
        movieCategoryDetailsVC.movieCategoryDetails = resource.getMovieCategoryDetails(type: movieCategory.type ?? .year, from: movies) as? [MovieCategoryDetail]
        self.navigationController?.pushViewController(movieCategoryDetailsVC, animated: true)
    }
    
    private func navigateToMoviesVC(movieCategory: MovieCategory) {
        guard let moviesVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.moviesVC) as? MoviesVC else { return }
        moviesVC.moviesTitle = movieCategory.type?.rawValue
        let resource = MovieResource(jsonUtility: JSONUtility(), responseHandler: ResponseHandler())
        moviesVC.movies = resource.getMovieCategoryDetails(type: movieCategory.type ?? .allMovies, from: movies) as? [Movie]
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    private func navigateToMovieDetailsVC(movie: Movie?) {
        guard let movieDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.movieDetailsVC) as?  MovieDetailsVC else { return }
        movieDetailsVC.movie = movie
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension MovieCategoriesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchText.isEmpty {
            if searchedMovies.count > 0 {
                tableView.clearBackground()
            } else {
                tableView.setMessage(CommonString.noResults)
            }
            return searchedMovies.count
        } else {
            tableView.clearBackground()
            return movieCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searchText.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.movieCell) as? MovieCell else {
                return UITableViewCell()
            }
            let movie = searchedMovies[indexPath.row]
            if let poster = movie.poster, let posterImgUrl = URL(string: poster) {
                cell.imgVWPoster.loadImage(fromURL: posterImgUrl, placeHolderImage: ImageName.defaultImg)
            }
            cell.lblName.text = movie.title
            cell.lblLanguage.text = movie.language
            cell.lblYear.text = movie.year
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as? SingleLblCell else {
                return UITableViewCell()
            }
            cell.lblTitle.text = movieCategories[indexPath.row].type?.rawValue
            return cell
        }
    }
}

//MARK: - Table view delegate methods
extension MovieCategoriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !searchText.isEmpty {
            navigateToMovieDetailsVC(movie: searchedMovies[indexPath.row])
        } else {
            let movieCategory = movieCategories[indexPath.row]
            switch movieCategory.type {
            case .allMovies:
                navigateToMoviesVC(movieCategory: movieCategory)
            default:
                navigateToWatchOptionValuesVC(movieCategory: movieCategory)
            }
        }
    }
}

//MARK: - Search bar delegate methods
extension MovieCategoriesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItemReference?.cancel()
        
        let animalSearchWorkItem = DispatchWorkItem {
            self.searchMovieWith(text: searchText, from: self.movieResource)
        }
        
        workItemReference = animalSearchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: animalSearchWorkItem)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    private func searchMovieWith(text: String, from resource: MovieResource?) {
        self.searchText = text
        resource?.searchMovie(text: text, movies: self.movies) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.searchedMovies = movies ?? []
                DispatchQueue.main.async {
                    self?.tblVWMovieCategories.reloadData()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.popupAlert(title: error.reason, message: nil, actionTitles: ["OK"], actions: [{_ in}])
                }
            }
        }
    }
}

