//
//  UserCredentialsModelMapper.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

enum UserCredentialsModelMapper {
    static func modelFrom(dto: UserCredentialsDTO) -> UserCredentials {
        return UserCredentials(accessToken: dto.accessToken,
                               tokenType: dto.tokenType,
                               expiresIn: dto.expiresIn,
                               refreshToken: dto.refreshToken,
                               createdAt: dto.createdAt)
    }

    static func refreshTokenDtoFrom(model: UserCredentials) -> RefreshTokenDTO {
        return RefreshTokenDTO(refreshToken: model.refreshToken,
                               clientId: Config.current.clientId,
                               clientSecret: Config.current.clientSecret)
    }
}
