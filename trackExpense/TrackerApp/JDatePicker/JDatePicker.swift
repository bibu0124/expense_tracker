//
//  JDatePicker.swift
//  Loving
//
//  Created by Kien Nguyen Duc on 23/7/2022.
//  Copyright © 2022 Kien Nguyen Duc. All rights reserved.
//

import UIKit

class JDatePicker: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!

    @IBAction func handleTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleTapSelectButton(_ sender: Any) {
        if datePickerMode == .countDownTimer {
            self.dismiss(animated: true) {
                self.didSelectCountDownTimer?(self.datePicker.countDownDuration)
            }
        } else {
            if let date = self.datePicker?.date {
                debugPrint("selected date: \(date)")
                self.dismiss(animated: true) {
                    self.didSelectDate?(date)
                }
            }
        }
    }
    
    var defaultDate = Date()
    var didSelectDate: ((Date) -> ())?
    var didSelectCountDownTimer: ((TimeInterval) -> ())?
    var didDismissView: (() -> ())?
    
    var datePickerMode: UIDatePicker.Mode = .date
    var needSetMinimumDate = false
    var needSetMaximumDate = false
    var timeZone: TimeZone?
    
    var datePickerMinuteInterval: Int? //DatePicker step by minute
    var startPickerTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setTitle("Hủy", for: .normal)
        selectButton.setTitle("Chọn", for: .normal)

        if let timeZone = timeZone {
            let dateFormater = DateFormatter()
            dateFormater.timeZone = timeZone
            dateFormater.dateFormat = "dd/MM/yyyy HH:mm"
            datePicker.timeZone = timeZone
            defaultDate = dateFormater.date(from: Date().stringLocal()) ?? Date()
        }
        
        if needSetMinimumDate {
            if datePickerMode == .date {
                datePicker.minimumDate = defaultDate
            }
        }
        
        if needSetMaximumDate {
            datePicker.maximumDate = Date()
        }
        
        datePicker.datePickerMode = datePickerMode
        datePicker.locale = Calendar.current.locale
        if datePickerMode == .countDownTimer {
            datePicker.countDownDuration = 60
        }
        
        //Setup for manage business hour
        if let datePickerMinuteInterval = datePickerMinuteInterval {
            self.datePicker.minuteInterval = datePickerMinuteInterval
        }
        
        if let startPickerTime = startPickerTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = self.timeZone
            if let date = dateFormatter.date(from: startPickerTime) {
                datePicker.date = date
            }
        }
        //******************//
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didDismissView?()
    }
}

extension Date {
    func localDate() -> Date {
        let nowUTC = self
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
}
