//
//  SingleDigitField.swift
//  Nails Express
//
//  Created by Kien Nguyen Duc on 30/05/2023.
//

import UIKit
class SingleDigitField: UITextField {
    var pressedDelete = false
    override func willMove(toSuperview newSuperview: UIView?) {
        keyboardType = .numberPad
        textAlignment = .center
        backgroundColor = .clear
        isSecureTextEntry = false
        isUserInteractionEnabled = false
        borderColor = APP_SILVER_COLOR
        borderWidth = 1
        cornerRadius = 5
        

        
    }
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
    }
}
