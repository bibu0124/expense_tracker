//
//  ClassRoomCVCell.swift
//  VietEduApp
//
//  Created by duynt0124 on 24/08/2023.
//

import UIKit
import Kingfisher
class HomeBodyCVCell: BaseCollectionViewCell {

    @IBOutlet weak var lbTitleEng: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func fillData(_ model: Category){
        
        lbTitleEng.text = model.name
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8119999766, blue: 0.4390000105, alpha: 1)
    }
}
