# MySurveyChallenge

## Introduction

Hello reviewers,

Welcome to my coding challenge project. Below, I'll provide an overview of the project's architecture, configurations, authentication approach, dependency injection, CI/CD setup, and optional features.

## Architecture

The project architecture is based on the principles outlined in [this article](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/). It follows a layered architecture pattern, adhering to the dependency rule of Clean Architecture. The layers include:

- Presentation
- Application
- Domain
- Device (optional, used for device-related APIs like KeychainAccess)
- Data

Regarding the Data layer, I consulted your company's Data layer at [this repo](https://github.com/nimblehq/ios-templates/tree/main) and I really like it. It's really simple and looks pretty similar to what Moya did (Moya Target and Moya Provider). I've revised it a bit so it can work with the Combine API and use the Japx library to parse JSONAPI data. Forgive me if you are not satisfied with this issue.

## Config + Secrets

For project configuration and secrets management, a simple xcconfig file is provided. While it's not recommended to store secrets in the repository, for the sake of convenience in this challenge, they are included. Ideally, secrets should be stored securely and shared internally within the team or injected during the build process.

## App Authentication

OAuth authentication and token refreshing are implemented as per Alamofire's documentation. You can find the details [here](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md).

## Dependency Injection
I've utilized Swinject for Dependency Injection, fostering loose coupling and enhancing testability.

## CI/CD

An Azure Pipeline is set up for continuous integration and deployment. It automates build and deployment processes based on commits to specific branches (main, develop, release/*). While I've written similar pipelines for my company, it took some time to recall the specifics. Additionally, some Fastlane lanes are drafted but may need refinement.

## Optional Features

Caching is implemented for the Surveys endpoint using the `SurveyRepositoryWithCachingImpl` class.

## Acknowledgements

I extend my gratitude to all reviewers for dedicating time to assess my coding challenge project. Thank you for your valuable feedback and consideration.