//
//  SurveyUIModel.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

struct SurveyUIModel {
    let title: String?
    let description: String?
    let coverImageUrl: String?
    let createdAt: Date?
    let activeAt: Date?

    var createdAtString: String {
        return createdAt?.formatRelativeWeekdayTime.uppercased() ?? ""
    }

    var activeAtString: String {
        return activeAt?.formatRelativeWeekdayTime ?? ""
    }
}
