//
//  Date+.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

public extension Date {
    static let oneHourTimeInterval: TimeInterval = 3600
    static let oneDayTimeInterval: TimeInterval = 24 * oneHourTimeInterval

    var formatRelativeWeekdayTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        dateFormatter.locale = Locale.current
        if self > Date.now.addingTimeInterval(-2 * Date.oneDayTimeInterval) {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
        }
        return dateFormatter.string(from: self)
    }
}
