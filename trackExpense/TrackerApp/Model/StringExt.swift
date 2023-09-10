//
//  StringExt.swift
//  TrackerApp
//
//  Created by duynt0124 on 08/09/2023.
//

import Foundation
extension String {
    func isValidDecimal(maxValue : Double) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        if self.count(of: decimalSeparator) > 1 {
            return false
        }
        let value = self.toLocalDoubleValue() ?? 0
        if value >= maxValue {
            return false
        }
        let arrs = self.components(separatedBy: decimalSeparator)
        if arrs.count > 1 {
            return arrs.last!.count <= 2
        }
        return true
    }
    
    func toLocalDoubleValue() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.usesGroupingSeparator = false
        return formatter.number(from: self)?.doubleValue
    }
}
