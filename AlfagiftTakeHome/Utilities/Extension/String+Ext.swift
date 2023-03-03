//
//  String+Ext.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 02/03/23.
//

import Foundation

extension String {
    func convertToFormattedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        guard let date = dateFormatter.date(from: self) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
