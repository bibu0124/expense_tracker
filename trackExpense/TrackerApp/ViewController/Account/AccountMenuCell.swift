//
//  AccountMenyCell.swift
//  VietEduApp
//
//  Created by Admin on 25/08/2023.
//

import UIKit

class AccountMenuCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(item: AccountMenuItem) {
        lblTitle.text = item.type?.rawValue
        imgIcon.image = item.image
    }
    
}
