//
//  BaseCollectionViewCell.swift
//  VietEduApp
//
//  Created by duynt0124 on 24/08/2023.
//

import Foundation
import UIKit
class BaseCollectionViewCell: UICollectionViewCell {
    var callBackWithAction: ((_ action: Int?, _ value: Any?) -> ())?
    var callBackWithAction2: ((_ action: Int?, _ value: Any? , _ value: Any?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
