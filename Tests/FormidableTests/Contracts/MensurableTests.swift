//
//  MensurableTests.swift
//  Formidable
//
//  Created by Adriano Costa on 07/02/25.
//

import Testing
import Foundation

@testable import Formidable

struct MensurableTests {
    
    @Test func ensureTheValueLengthConsistency() throws {
        #expect(1.length == 1)
        #expect([1, 2].length == 2)
        #expect(Double(2.4).length == 2.4)
        #expect(Float(2.4).length == 2.4000000953674316)
        #expect(makeDate(year: 2024, month: 03, day: 05).length == 1709607600.0)
        #expect("123".data(using: .utf8)?.length == 3)
    }
    
    // MARK: - Private Methods
    
    private func makeDate(
        _ calendar: Calendar = .current,
        year: Int,
        month: Int,
        day: Int
    ) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
    
}
