//
//  WatchOptionValuesVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class WatchOptionValuesVC: UIViewController {
    
    @IBOutlet weak var tblVW: UITableView!
    
    var option: WatchOption?
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = option?.type?.rawValue
    }
    
    // MARK: - Navigation
    private func navigateToMoviesVC(watchOptionValue: WatchOptionValue?) {
        let moviesVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersID.moviesVC) as! MoviesVC
        moviesVC.watchOptionValue = watchOptionValue
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
}

// MARK: - Table view data source methods
extension WatchOptionValuesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option?.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as! SingleLblCell
        cell.lblTitle.text = option?.values?[indexPath.row].title
        return cell
    }
}

//MARK: - Table view delegate methods
extension WatchOptionValuesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMoviesVC(watchOptionValue: option?.values?[indexPath.row])
    }
}
