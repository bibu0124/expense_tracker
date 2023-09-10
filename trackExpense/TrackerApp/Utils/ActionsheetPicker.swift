//
//  ActionsheetPicker.swift
//  VietApp
//
//  Created by Admin on 25/03/2023.
//

import Foundation
import ActionSheetPicker_3_0
import AYPopupPickerView

class ActionsheetPicker {
    
    static func showInfoPicker(_ view: UIView,_ array: [String],_ completion: @escaping ((_ value: String?, _ selectedIndex : Int?) -> Void)) {
        let popupPickerView = AYPopupPickerView()
        popupPickerView.doneButton.setTitle("Xong", for: .normal)
        popupPickerView.cancelButton.setTitle("Huỷ", for: .normal)
        popupPickerView.display(itemTitles: array, doneHandler: {
            let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
            completion(array[selectedIndex], selectedIndex)
        })
    }
    
    static func showDatePicker(origin : UIView, _ mode : UIDatePicker.Mode = .date, maxDate : Date?, minDate : Date?,  completeHandler: @escaping(_ item : Date?)->()) {
        let popupPickerView = AYPopupDatePickerView()
//        popupPickerView.doneButton.setTitle("Xong", for: .normal)
//        popupPickerView.cancelButton.setTitle("Huỷ", for: .normal)
        popupPickerView.datePickerView.minimumDate = minDate
        popupPickerView.datePickerView.maximumDate = maxDate
        popupPickerView.datePickerView.datePickerMode = mode
        popupPickerView.display(defaultDate: Date(), doneHandler: { date in
            completeHandler(date)
        })
    }
}
