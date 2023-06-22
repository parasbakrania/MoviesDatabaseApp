//
//  MovieCell.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgVWPoster: LazyImgVW!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
