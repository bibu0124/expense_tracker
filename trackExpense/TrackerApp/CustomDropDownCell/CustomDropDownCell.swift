//
//  CustomDropDownCell.swift
//  iNails-iOS
//
//  Created by kiennd on 07/10/2022.
//

import UIKit
import DropDown

class CustomDropDownCell: DropDownCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
