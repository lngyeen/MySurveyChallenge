//
//  LoadingView.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            SurveyCardView(survey: SurveyUIModelMapper.uiModelFrom(model: Survey.sample))
                .redacted(reason: .placeholder)
        }
    }
}

#Preview {
    LoadingView()
}
