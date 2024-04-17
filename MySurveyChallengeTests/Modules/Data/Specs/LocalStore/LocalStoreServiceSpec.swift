//
//  LocalStoreServiceSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/17/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class LocalStoreServiceSpec: QuickSpec {
    override class func spec() {
        describe("LocalStoreServiceImpl") {
            var sut: LocalStoreServiceImpl!

            beforeEach {
                sut = LocalStoreServiceImpl()
            }

            afterEach {
                sut = nil
            }

            context("saving data to cache") {
                it("should save data successfully") {
                    let data = "Test Data".data(using: .utf8)!
                    let fileName = "testData.txt"

                    expect { try sut.saveDataToCache(data, fileName: fileName) }.toNot(throwError())
                }
            }

            context("loading data from cache") {
                it("should load data successfully") {
                    let dataToSave = "Test Data".data(using: .utf8)!
                    let fileName = "testData.txt"

                    expect { try sut.saveDataToCache(dataToSave, fileName: fileName) }.toNot(throwError())

                    let loadedData = try? sut.loadDataFromCache(fileName)
                    expect(loadedData).toNot(beNil())
                    expect(String(data: loadedData!, encoding: .utf8)).to(equal("Test Data"))
                }

                it("should return nil when file does not exist") {
                    let fileName = "nonExistentFile.txt"
                    let loadedData = try? sut.loadDataFromCache(fileName)
                    expect(loadedData).to(beNil())
                }
            }
        }
    }
}
