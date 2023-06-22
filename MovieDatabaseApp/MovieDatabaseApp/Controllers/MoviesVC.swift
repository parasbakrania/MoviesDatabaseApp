//
//  MoviesVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class MoviesVC: UIViewController {
    
    @IBOutlet weak var tblVW: UITableView!
    
    var watchOptionValue: WatchOptionValue?
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = watchOptionValue?.title
    }
    
    // MARK: - Navigation
    private func navigateToMovieDetailsVC(movie: Movie?) {
        let movieDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.movieDetailsVC) as! MovieDetailsVC
        movieDetailsVC.movie = movie
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchOptionValue?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.movieCell) as! MovieCell
        let movie = watchOptionValue?.movies?[indexPath.row]
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
        navigateToMovieDetailsVC(movie: watchOptionValue?.movies?[indexPath.row])
    }
}
