//
//  KeychainStoreServiceSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class KeychainStoreServiceSpec: QuickSpec {
    override class func spec() {
        describe("KeychainStoreService") {
            let credentialsField: SecureStoreField = .credentials

            var keychainStoreService: KeychainStoreService!
            var mockAdapter: KeychainFrameworkAdapterMock!

            describe(" perform save data action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.setDataDataKeyStringVoidThrowableError = .none

                        expect { try keychainStoreService.saveData(Data(), key: credentialsField) }.toNot(throwError())

                        expect(mockAdapter.setDataDataKeyStringVoidCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.setDataDataKeyStringVoidThrowableError = .some("Error")

                        expect { try keychainStoreService.saveData(Data(), key: credentialsField) }.to(throwError())

                        expect(mockAdapter.setDataDataKeyStringVoidCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform save string action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.setStringStringKeyStringVoidThrowableError = .none

                        expect { try keychainStoreService.saveString("String", key: credentialsField) }.toNot(throwError())

                        expect(mockAdapter.setStringStringKeyStringVoidCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.setStringStringKeyStringVoidThrowableError = .some("Error")

                        expect { try keychainStoreService.saveString("String", key: credentialsField) }.to(throwError())

                        expect(mockAdapter.setStringStringKeyStringVoidCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform get data action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.getDataKeyStringDataReturnValue = Data()

                        let storedData = try keychainStoreService.getData(credentialsField)

                        expect(storedData).toNot(beNil())
                        expect(storedData).toNot(throwError())
                        expect(mockAdapter.getDataKeyStringDataCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.getDataKeyStringDataThrowableError = .some("Error")

                        expect { try keychainStoreService.getData(credentialsField) }.to(throwError())
                        expect(mockAdapter.getDataKeyStringDataCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform get string action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.getKeyStringStringReturnValue = "String"

                        let storedData = try keychainStoreService.getString(credentialsField)

                        expect(storedData).toNot(beNil())
                        expect(storedData).toNot(throwError())
                        expect(mockAdapter.getKeyStringStringCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.getKeyStringStringThrowableError = .some("Error")

                        expect { try keychainStoreService.getString(credentialsField) }.to(throwError())
                        expect(mockAdapter.getKeyStringStringCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform remove action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.removeKeyStringVoidThrowableError = .none

                        expect { try keychainStoreService.remove(credentialsField) }.toNot(throwError())
                        expect(mockAdapter.removeKeyStringVoidCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.removeKeyStringVoidThrowableError = .some("Error")

                        expect { try keychainStoreService.remove(credentialsField) }.to(throwError())
                        expect(mockAdapter.removeKeyStringVoidCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform save object action") {
                let codableModel = DummyCodableModel(id: "10", title: "title", message: "message")

                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.setDataDataKeyStringVoidThrowableError = .none

                        expect { try keychainStoreService.saveObject(codableModel, key: credentialsField) }.toNot(throwError())

                        expect(mockAdapter.setDataDataKeyStringVoidCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.setDataDataKeyStringVoidThrowableError = .some("Error")

                        expect { try keychainStoreService.saveObject(codableModel, key: credentialsField) }.to(throwError())

                        expect(mockAdapter.setDataDataKeyStringVoidCallsCount).to(equal(1))
                    }
                }
            }

            describe(" perform get object action") {
                context(" when adapter DOES NOT throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES NOT throws error") {
                        mockAdapter.getDataKeyStringDataReturnValue = DummyCodableModel.json.data

                        let object: DummyCodableModel? = try keychainStoreService.getObject(credentialsField)

                        expect(object).toNot(beNil())

                        expect(mockAdapter.getDataKeyStringDataCallsCount).to(equal(1))
                    }
                }

                context(" when adapter DOES throw error") {
                    beforeEach {
                        mockAdapter = KeychainFrameworkAdapterMock()
                        keychainStoreService = KeychainStoreService(adapter: mockAdapter)
                    }

                    it(" it DOES throws error") {
                        mockAdapter.getDataKeyStringDataThrowableError = .some("Error")

                        expect { let _: DummyCodableModel? = try keychainStoreService.getObject(credentialsField) }.to(throwError())

                        expect(mockAdapter.getDataKeyStringDataCallsCount).to(equal(1))
                    }
                }
            }
        }
    }
}
