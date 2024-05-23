//
//  DateExtension.swift
//  GHLookup
//
//  Created by JJ on 23/05/24.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    
}
