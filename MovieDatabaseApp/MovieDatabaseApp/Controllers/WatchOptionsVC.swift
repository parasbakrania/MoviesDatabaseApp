//
//  WatchOptionsVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import UIKit

class WatchOptionsVC: UIViewController {
    
    @IBOutlet weak var tblVW: UITableView!
    
    private var movies: [Movie] = []
    private var watchOptions: [WatchOption] = []
    
    private var searchText = ""
    private var filteredMovies: [Movie] = []
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let resource = MovieResource()
        resource.getMovies(fileName: ProjectImp.fileName, fileType: ProjectImp.fileType) { [weak self] result in
            self?.movies = result ?? []
            self?.watchOptions = resource.getWatchOptions(from: self?.movies ?? [])
            DispatchQueue.main.async {
                self?.tblVW.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToWatchOptionValuesVC(option: WatchOption?) {
        let watchOptionValuesVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.watchOptionValuesVC) as! WatchOptionValuesVC
        watchOptionValuesVC.option = option
        self.navigationController?.pushViewController(watchOptionValuesVC, animated: true)
    }
    
    private func navigateToMovieDetailsVC(movie: Movie?) {
        let movieDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.movieDetailsVC) as! MovieDetailsVC
        movieDetailsVC.movie = movie
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension WatchOptionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchText.isEmpty {
            if filteredMovies.count > 0 {
                tableView.clearBackground()
            } else {
                tableView.setMessage(CommonString.noResults)
            }
            return filteredMovies.count
        } else {
            tableView.clearBackground()
            return watchOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searchText.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.movieCell) as! MovieCell
            let movie = filteredMovies[indexPath.row]
            if let poster = movie.poster, let posterImgUrl = URL(string: poster) {
                cell.imgVWPoster.loadImage(fromURL: posterImgUrl, placeHolderImage: ImageName.defaultImg)
            }
            cell.lblName.text = movie.title
            cell.lblLanguage.text = movie.language
            cell.lblYear.text = movie.year
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as! SingleLblCell
        cell.lblTitle.text = watchOptions[indexPath.row].type?.rawValue
        return cell
    }
}

//MARK: - Table view delegate methods
extension WatchOptionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !searchText.isEmpty {
            navigateToMovieDetailsVC(movie: filteredMovies[indexPath.row])
        } else {
            navigateToWatchOptionValuesVC(option: watchOptions[indexPath.row])
        }
    }
}

//MARK: - Search bar delegate methods
extension WatchOptionsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        if searchText.isEmpty {
            filteredMovies = []
        } else {
            filteredMovies = movies.filter({ ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) || ($0.genre?.joined().localizedCaseInsensitiveContains(searchText) ?? false) || ($0.actors?.joined().localizedCaseInsensitiveContains(searchText) ?? false) || ($0.director?.joined().localizedCaseInsensitiveContains(searchText) ?? false) })
        }
        DispatchQueue.main.async {
            self.tblVW.reloadData()
        }
    }
}
