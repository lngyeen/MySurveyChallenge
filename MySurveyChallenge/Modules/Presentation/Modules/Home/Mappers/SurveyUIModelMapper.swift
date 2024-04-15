//
//  SurveyUIModelMapper.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

enum SurveyUIModelMapper {
    static func uiModelFrom(model: Survey) -> SurveyUIModel {
        return SurveyUIModel(title: model.title,
                             description: model.description,
                             coverImageUrl: model.coverImageUrl,
                             createdAt: model.createdAt,
                             activeAt: model.activeAt)
    }
}
