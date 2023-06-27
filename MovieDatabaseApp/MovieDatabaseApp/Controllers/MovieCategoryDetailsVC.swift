//
//  MovieCategoryDetailsVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 27/06/23.
//

import UIKit

class MovieCategoryDetailsVC: UIViewController {
    
    @IBOutlet weak var tblVWMovieCategoryDetails: UITableView!
    
    var movieCategoryTitle: String?
    var movieCategoryDetails: [MovieCategoryDetail]?
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieCategoryTitle
    }
    
    // MARK: - Navigation
    private func navigateToMoviesVC(movieCategoryDetail: MovieCategoryDetail?) {
        let moviesVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.moviesVC) as! MoviesVC
        moviesVC.moviesTitle = movieCategoryDetail?.title
        moviesVC.movies = movieCategoryDetail?.movies
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension MovieCategoryDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategoryDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as! SingleLblCell
        cell.lblTitle.text = movieCategoryDetails?[indexPath.row].title
        return cell
    }
}

//MARK: - Table view delegate methods
extension MovieCategoryDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMoviesVC(movieCategoryDetail: movieCategoryDetails?[indexPath.row])
    }
}
