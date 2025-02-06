//
//  Date+Extension.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 06/02/25.
//

import Foundation

extension Date {
    
    func remove(years: Int, calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .year, value: -years, to: self)!
    }
    
    func zeroSeconds(_ calendar: Calendar = .current) -> Date {
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: self
        )
        return calendar.date(from: dateComponents)!
    }
    
}
