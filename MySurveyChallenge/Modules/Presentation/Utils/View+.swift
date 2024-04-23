//
//  View+.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import SwiftUI

public extension View {
    var typeName: String {
        return String(describing: type(of: self))
    }

    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
