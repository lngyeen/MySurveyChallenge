//
//  ConsoleLogEventMonitor.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

class ConsoleLogEventMonitor: EventMonitor {
    public let queue = DispatchQueue(label: "dev.luunguyen.consoleLogEventMonitor")

    func requestDidResume(_ request: Request) {
        queue.async {
            print("""
                [[REQ]==================================================]
                [URL]: \(request.request?.url?.absoluteString ?? "")
                \(request.cURLDescription())
            """)
        }
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        queue.async {
            print("""
                [[RESP]==================================================]
                [URL]: \(request.request?.url?.absoluteString ?? "")
                \(response.debugDescription)
            """)
        }
    }
}
