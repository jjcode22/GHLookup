//
//  StringExtension.swift
//  GHLookup
//
//  Created by JJ on 23/05/24.
//

import Foundation

extension String{
    
    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        //we call self because this function is an extension on String type. i.e str.convertToDate()
        return dateFormatter.date(from: self) 
    }
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {
            return "N/A"
        }
        return date.convertToMonthYearFormat()
    }
}
