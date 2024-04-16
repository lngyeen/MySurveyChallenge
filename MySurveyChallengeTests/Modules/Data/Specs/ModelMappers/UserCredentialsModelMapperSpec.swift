//
//  UserCredentialsModelMapperSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class UserCredentialsModelMapperSpec: QuickSpec {
    override class func spec() {
        describe("UserCredentialsModelMapper") {
            describe("perform modelFrom") {
                it("it returns UserCredentials") {
                    let dto = UserCredentialsDTO(id: "id",
                                                 type: "type",
                                                 accessToken: "accessToken",
                                                 tokenType: "tokenType",
                                                 expiresIn: 3600,
                                                 refreshToken: "refreshToken",
                                                 createdAt: 1618345742.0)

                    let userCredentials = UserCredentialsModelMapper.modelFrom(dto: dto)

                    expect(userCredentials.accessToken).to(equal("accessToken"))
                    expect(userCredentials.tokenType).to(equal("tokenType"))
                    expect(userCredentials.expiresIn).to(equal(3600))
                    expect(userCredentials.refreshToken).to(equal("refreshToken"))
                    expect(userCredentials.createdAt).to(equal(1618345742.0))
                }
            }

            describe("perform refreshTokenDtoFrom") {
                it("it returns RefreshTokenDTO") {
                    let userCredentials = UserCredentials(accessToken: "accessToken",
                                                          tokenType: "tokenType",
                                                          expiresIn: 3600,
                                                          refreshToken: "refreshToken",
                                                          createdAt: 1618345742.0)

                    let refreshTokenDTO = UserCredentialsModelMapper.refreshTokenDtoFrom(model: userCredentials)

                    expect(refreshTokenDTO.refreshToken).to(equal("refreshToken"))
                    expect(refreshTokenDTO.clientId).to(equal(Config.current.clientId))
                    expect(refreshTokenDTO.clientSecret).to(equal(Config.current.clientSecret))
                }
            }
        }
    }
}
