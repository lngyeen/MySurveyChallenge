//
//  SurveyCardView.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import CachedAsyncImage
import SwiftUI

struct SurveyCardView: View {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)

    let survey: SurveyUIModel

    init(survey: SurveyUIModel) {
        self.survey = survey
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            surveyInfoView
            Spacer()
                .frame(width: 56)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 26)
        .background(backgroundView)
        .background(Color(R.color.colorDefaultBackgroundDark))
    }

    private var surveyInfoView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                createdAtLabel
                activeAtLabel
            }
            Spacer()
            VStack(alignment: .leading, spacing: 24) {
                titleLabel
                descriptionLabel
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomLeading
        )
    }

    private var createdAtLabel: some View {
        Text(survey.createdAtString.uppercased())
            .font(Font(R.font.neuzeitSLTStdBookHeavy(size: 13)!))
            .lineSpacing(18 - 13)
            .foregroundColor(Color(R.color.colorDefaultOnSurfaceInverted))
            .lineLimit(2)
    }

    private var activeAtLabel: some View {
        Text(survey.activeAtString)
            .font(Font(R.font.neuzeitSLTStdBookHeavy(size: 34)!))
            .lineSpacing(41 - 34)
            .foregroundColor(Color(R.color.colorDefaultOnSurfaceInverted))
            .lineLimit(2)
    }

    private var titleLabel: some View {
        Text(survey.title ?? "")
            .font(Font(R.font.neuzeitSLTStdBookHeavy(size: 28)!))
            .lineSpacing(34 - 28)
            .foregroundColor(Color(R.color.colorDefaultOnSurfaceInverted))
            .lineLimit(2)
    }

    private var descriptionLabel: some View {
        Text(survey.description ?? "")
            .font(Font(R.font.neuzeitSLTStdBook(size: 17)!))
            .lineSpacing(22 - 17)
            .foregroundColor(Color(R.color.colorDefaultOnSurfaceSubdued))
            .lineLimit(2)
    }

    @ViewBuilder
    private var backgroundView: some View {
        if let coverImageUrl = survey.coverImageUrl,
           let url = URL(string: coverImageUrl)
        {
            GeometryReader { geo in
                CachedAsyncImage(url: url, urlCache: SurveyCardView.imageCache) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(R.color.colorDefaultOnSurfaceInverted)))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width,
                                   height: geo.size.height)
                            .clipped()

                    case .failure:
                        EmptyView()

                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    SurveyCardView(survey: SurveyUIModelMapper.uiModelFrom(model: Survey.sample))
}
