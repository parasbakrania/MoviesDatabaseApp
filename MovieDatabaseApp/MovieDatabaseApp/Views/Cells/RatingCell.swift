//
//  RatingCell.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 22/06/23.
//

import UIKit

class RatingCell: UITableViewCell {
    
    @IBOutlet weak var txtFieldRatingSrc: UITextField!
    @IBOutlet weak var lblRatingValue: UILabel!
    
    let pickerVW = CustomPickerVW()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtFieldRatingSrc.inputView = pickerVW
        txtFieldRatingSrc.inputAccessoryView = pickerVW.toolbar
        txtFieldRatingSrc.delegate = self
        
        setUpTxtFieldRightVW()
    }
    
    private func setUpTxtFieldRightVW() {
        txtFieldRatingSrc.rightViewMode = .always
        let iconView = UIImageView(frame:
                                    CGRect(x: -5, y: 0, width: 20, height: 13))
        iconView.image = UIImage(systemName: "chevron.down")
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 0, y: 0, width: 25, height: 13))
        iconContainerView.addSubview(iconView)
        txtFieldRatingSrc.rightView = iconContainerView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Text field delegate methods
extension RatingCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
