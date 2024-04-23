//
//  SurveyListView.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI
import SwiftUIPager

struct SurveyListView: View {
    let surveys: [Survey]
    let onPageChanged: ((Int) -> Void)?

    @StateObject var page: Page = .first()
    @State var routeToDetailScreen: Bool?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            surveysPageView

            HStack {
                pageControlView
                Spacer()
            }

            routeToDetailButton

            navigationLink
        }
        .accessibilityLabel(Text(typeName))
    }

    private var surveysPageView: some View {
        GeometryReader { geometry in
            Pager(page: page,
                  data: surveys,
                  id: \.id,
                  content: {
                      SurveyCardView(survey: SurveyUIModelMapper.uiModelFrom(model: $0))
                          .padding(EdgeInsets(top: geometry.safeAreaInsets.top,
                                              leading: 0,
                                              bottom: geometry.safeAreaInsets.bottom,
                                              trailing: 0))
                  })
                .onPageChanged(onPageChanged)
                .ignoresSafeArea()
                .accessibilityLabel(Text("Pager"))
        }
    }

    private var pageControlView: some View {
        PageControlView(currentPage: $page.index,
                        numberOfPages: surveys.count)

            .padding(.leading, -14)
            .padding(.bottom, 174)
            .ignoresSafeArea()
    }

    private var routeToDetailButton: some View {
        CircularButton(action: {
            self.routeToDetailScreen = true
        }) {
            Image(R.image.arrow)
        }
        .padding(.bottom, 20)
        .padding(.trailing, 26)
    }

    private var navigationLink: some View {
        NavigationLink(
            destination: SurveyDetailScreen(),
            tag: true,
            selection: $routeToDetailScreen,
            label: { EmptyView() }
        )
        .hidden()
    }
}

#Preview {
    NavigationView {
        SurveyListView(surveys: Survey.samples) { _ in }
    }
}
