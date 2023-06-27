//
//  MovieDetailsVC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var tblVWMovieDetails: UITableView!
    @IBOutlet weak var imgVWPoster: LazyImgVW!
    
    var movie: Movie?
    var movieInfos: [MovieInfo] = []
    
    var selectedRating: Rating?
    var selectingRating: Rating?
    var ratingCellIndexPath: IndexPath?
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
        setupUI()
    }
    
    //MARK: - Setup UI methods
    private func setupUI() {
        self.navigationItem.title = movie?.title
        if let poster = movie?.poster, let posterImgUrl = URL(string: poster) {
            imgVWPoster.loadImage(fromURL: posterImgUrl, placeHolderImage: ImageName.defaultImg)
        }
    }
    
    private func initializeData() {
        movieInfos = [MovieInfo(type: .plot, values: movie?.plot),
                      MovieInfo(type: .castnCrew, values: movie?.actors?.joined(separator: ", ")),
                      MovieInfo(type: .releasedDate, values: movie?.released),
                      MovieInfo(type: .genre, values: movie?.genre?.joined(separator: ", ")),
                      MovieInfo(type: .rating, values: movie?.ratings)]
        selectedRating = movie?.ratings?.first
    }
}

// MARK: - Table view data source methods
extension MovieDetailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieInfos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movieInfos[indexPath.section].type == .rating {
            ratingCellIndexPath = indexPath
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.ratingCell) as! RatingCell
            cell.txtFieldRatingSrc.text = selectedRating?.source
            cell.lblRatingValue.text = selectedRating?.value
            cell.pickerVW.dataSource = self
            cell.pickerVW.delegate = self
            cell.pickerVW.toolbarDelegate = self
            cell.pickerVW.reloadAllComponents()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as! SingleLblCell
            cell.lblTitle.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            cell.lblTitle.text = movieInfos[indexPath.section].values as? String
            return cell
        }
    }
}

//MARK: - Table view delegate methods
extension MovieDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.singleLblCell) as! SingleLblCell
        cell.lblTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cell.lblTitle.text = movieInfos[section].type?.rawValue
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Picker view data source methods
extension MovieDetailsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movie?.ratings?.count ?? 0
    }
}

//MARK: - Picker view delegate methods
extension MovieDetailsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return movie?.ratings?[row].source
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectingRating = movie?.ratings?[row]
    }
}

//MARK: - Custom picker view delegate methods
extension MovieDetailsVC: CustomPickerVWDelegate {
    func didTapDone() {
        selectedRating = selectingRating
        guard let indexPath = ratingCellIndexPath,
              let cell = tblVWMovieDetails.cellForRow(at: indexPath) as? RatingCell else {
            return
        }
        cell.txtFieldRatingSrc.text = selectedRating?.source
        cell.lblRatingValue.text = selectedRating?.value
        cell.txtFieldRatingSrc.resignFirstResponder()
    }
    
    func didTapCancel() {
        guard let indexPath = ratingCellIndexPath,
              let cell = tblVWMovieDetails.cellForRow(at: indexPath) as? RatingCell else {
            return
        }
        cell.txtFieldRatingSrc.resignFirstResponder()
    }
}
