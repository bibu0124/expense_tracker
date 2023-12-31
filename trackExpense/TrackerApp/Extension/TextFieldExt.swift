//
//  TextFieldExt.swift
//  VietApp
//
//  Created by Admin on 27/06/2023.
//

import Foundation
import UIKit
extension UITextField {
    func addPaddingRightIcon(image : UIImage?) {
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView = UIImageView(image: image?.imageWithInsets(insets: .init(top: 0, left: 0, bottom: 0, right: 0)))
    }
}
