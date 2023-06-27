//
//  MoviesVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class MoviesVC: UIViewController {
    
    @IBOutlet weak var tblVWMovies: UITableView!
    
    var moviesTitle: String?
    var movies: [Movie]?
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = moviesTitle
    }
    
    // MARK: - Navigation
    private func navigateToMovieDetailsVC(movie: Movie?) {
        guard let movieDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.movieDetailsVC) as? MovieDetailsVC else { return }
        movieDetailsVC.movie = movie
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.movieCell) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = movies?[indexPath.row]
        if let poster = movie?.poster, let posterImgUrl = URL(string: poster) {
            cell.imgVWPoster.loadImage(fromURL: posterImgUrl, placeHolderImage: ImageName.defaultImg)
        }
        cell.lblName.text = movie?.title
        cell.lblLanguage.text = movie?.language
        cell.lblYear.text = movie?.year
        return cell
    }
}

//MARK: - Table view delegate methods
extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMovieDetailsVC(movie: movies?[indexPath.row])
    }
}
