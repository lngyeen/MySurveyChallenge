//
//  Config.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation

struct Config {
    let scheme: String
    let host: String
    let clientId: String
    let clientSecret: String

    init() {
        scheme = ""
        host = ""
        clientId = ""
        clientSecret = ""
    }

    enum CodingKeys: String, CodingKey {
        case scheme = "Scheme"
        case host = "Host"
        case clientId = "ClientId"
        case clientSecret = "ClientSecret"
    }

    var baseHost: String {
        return "\(scheme)://\(host)"
    }
}

struct ConfigContainer: Decodable {
    let Config: Config
}

extension Config: Decodable {
    static var current: Config = {
        guard let infoURL = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            fatalError("No info.plist in main bundle")
        }
        do {
            let infoData = try Data(contentsOf: infoURL)
            let decoder = PropertyListDecoder()
            let item = try decoder.decode(ConfigContainer.self, from: infoData)
            return item.Config
        } catch {
            return Config()
        }
    }()
}
