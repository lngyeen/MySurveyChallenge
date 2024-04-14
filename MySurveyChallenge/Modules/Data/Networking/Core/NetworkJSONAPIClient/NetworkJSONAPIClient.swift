//
//  NetworkJSONAPIClient.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Combine
import Foundation
import Japx

final class NetworkJSONAPIClient: NetworkAPIClient {
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    private lazy var japxDecoder: JapxDecoder = {
        var jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            guard let date = NetworkJSONAPIClient.dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
            }
            return date
        }
        let decoder = JapxDecoder(jsonDecoder: jsonDecoder)
        return decoder
    }()

    private let session: Session

    init(session: Session = Session.default) {
        self.session = session
    }

    func performRequest<T: Codable>(_ configuration: RequestEndpoint,
                                    for type: T.Type) -> AnyPublisher<DataResponse<T, NetworkAPIError>, Never>
    {
        return request(session: session,
                       configuration: configuration,
                       decoder: japxDecoder)
    }

    private func request<T: Codable>(session: Session,
                                     configuration: RequestEndpoint,
                                     decoder: JapxDecoder) -> AnyPublisher<DataResponse<T, NetworkAPIError>, Never>
    {
        session.request(
            configuration.url,
            method: configuration.method,
            parameters: configuration.parameters,
            encoding: configuration.encoding,
            headers: configuration.headers,
            interceptor: configuration.interceptor
        )
        .validate()
        .publishData(queue: .global(qos: .background))
        .map { response in
            response
                .mapError { error in
                    if error.isSessionTaskError {
                        return NetworkAPIError.noInternet
                    }

                    let backendErrors = response.data.flatMap { try? JSONDecoder().decode(BackendErrors.self, from: $0) }
                    let networkError = NetworkingError(initialError: error, backendErrors: backendErrors)
                    return NetworkAPIError.networking(networkError)
                }
        }
        .map { response in
            response
                .tryMap { data in
                    try decoder.decode(JapxResponse<T>.self, from: data).data
                }
        }
        .map { response in
            response
                .mapError { error in
                    switch error {
                        case let networkAPIError as NetworkAPIError:
                            return networkAPIError
                        case let japxError as JapxError:
                            return NetworkAPIError.other(japxError.caseName())
                        default:
                            return NetworkAPIError.other(error.localizedDescription)
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

extension JapxError {
    func caseName() -> String {
        let mirror = Mirror(reflecting: self)
        if let label = mirror.children.first?.label {
            return label
        }
        return "Unknown"
    }
}
