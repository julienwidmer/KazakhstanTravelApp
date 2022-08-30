//
//  DateExtension.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-08.
//

import Foundation

extension Date {
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
    func getReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate(from dateFormat: String="yyyy-MM-dd HH:mm:ss",
                to format: String?=nil) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
    }
}
