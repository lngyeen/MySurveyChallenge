//
//  SurveyModelMapper.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Foundation

enum SurveyModelMapper {
    static func modelFrom(dto: SurveyDTO) -> Survey {
        return Survey(id: dto.id, type: dto.type,
                      title: dto.title,
                      description: dto.description,
                      coverImageUrl: dto.coverImageUrl,
                      surveyType: dto.surveyType,
                      createdAt: dto.createdAt,
                      activeAt: dto.activeAt)
    }
}
