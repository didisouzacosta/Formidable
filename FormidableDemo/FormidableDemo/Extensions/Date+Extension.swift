//
//  Date+Extension.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 06/02/25.
//

import Foundation

extension Date {

    // MARK: - Public Methods

    func subtracting(years: Int, calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .year, value: -years, to: self) ?? self
    }

    func zeroSeconds(_ calendar: Calendar = .current) -> Date {
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: self
        )

        return calendar.date(from: dateComponents) ?? self
    }

}
