// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    // MARK: - Public lanes

    func testLane() {
        desc("Run test")

        scan(
            scheme: .userDefined(AppInfo.scheme),
            devices: .userDefined(AppInfo.testDevices),
            testplan: .userDefined(AppInfo.testplan),
            codeCoverage: .userDefined(true),
            outputDirectory: AppInfo.testOutput,
            xcodebuildFormatter: xcodebuildFormatter
        )
    }

    func appStoreLane() {
        desc("Build and upload app to AppStore")

        // Connect AppStore
        connectToAppStore()

        // Increment BuildNumber
        increaseBuildNumber()

        // Sync AppStore certificate and provisioning profile
        syncAppStoreCertificateAndProvisioningProfile()

        // Build app with app-store exportMethod
        buildAppStoreVersion()

        // Upload ipa to AppStore
        uploadBuildToAppStore()
    }

    func testFlightLane() {
        desc("Build and upload app to TestFlight")

        // Connect AppStore
        connectToAppStore()

        // Increment BuildNumber
        increaseBuildNumber()

        // Sync AppStore certificate and provisioning profile
        syncAppStoreCertificateAndProvisioningProfile()

        // Build app with app-store exportMethod
        buildAppStoreVersion()

        // Upload ipa to TestFlight
        uploadBuildToTestFlight()
    }

    // MARK: - Private function

    private var xcodebuildFormatter: String { return "Pods/xcbeautify/xcbeautify" }

    private func connectToAppStore() {
        appStoreConnectApiKey(
            keyId: AppSecrets.appStoreAPIKeyId,
            issuerId: AppSecrets.appStoreIssuerId,
            keyContent: .userDefined(AppSecrets.appStoreConnectAPIKey),
            isKeyContentBase64: .userDefined(true)
        )
    }

    private func increaseBuildNumber() {
        let buildNumber = latestTestflightBuildNumber(appIdentifier: AppInfo.appIdentifier,
                                                      teamId: .userDefined(AppInfo.appleTeamId))
        incrementBuildNumber(buildNumber: .userDefined("\(buildNumber + 1)"))
    }

    private func syncAppStoreCertificateAndProvisioningProfile() {
        createFastlaneKeychain()
        match(
            type: "appstore",
            appIdentifier: [AppInfo.appIdentifier],
            username: .userDefined(AppInfo.appleId),
            teamId: .userDefined(AppInfo.appleTeamId),
            gitUrl: AppInfo.matchRepoUrl,
            keychainName: AppInfo.keychainName,
            keychainPassword: .userDefined(AppInfo.keychainPassword)
        )
        updateCodeSigningSettingsToManual()
    }

    private func updateCodeSigningSettingsToManual() {
        updateCodeSigningSettings(
            path: AppInfo.projectPath,
            useAutomaticSigning: .userDefined(false),
            teamId: .userDefined(AppInfo.appleTeamId),
            codeSignIdentity: .userDefined("iPhone Distribution"),
            profileName: .userDefined(appStoreProfileName())
        )
    }

    private func createFastlaneKeychain() {
        createKeychain(
            name: .userDefined(AppInfo.keychainName),
            password: AppInfo.keychainPassword,
            defaultKeychain: .userDefined(true),
            unlock: .userDefined(true),
            timeout: 3600
        )
    }

    private func buildAppStoreVersion() {
        gym(
            scheme: .userDefined(AppInfo.scheme),
            clean: .userDefined(true),
            includeSymbols: .userDefined(true),
            exportMethod: .userDefined("appstore"),
            exportOptions: .userDefined([
                "provisioningProfiles": [AppInfo.appIdentifier: appStoreProfileName()],
            ]),
            xcodebuildFormatter: xcodebuildFormatter
        )
    }

    private func uploadBuildToAppStore() {
        deliver(
            appIdentifier: .userDefined(AppInfo.appIdentifier),
            skipScreenshots: .userDefined(true),
            skipMetadata: .userDefined(true),
            force: .userDefined(true),
            runPrecheckBeforeSubmit: .userDefined(false)
        )
    }

    private func uploadBuildToTestFlight() {
        pilot(
            appIdentifier: .userDefined(AppInfo.appIdentifier),
            skipWaitingForBuildProcessing: .userDefined(true)
        )
    }

    private func appStoreProfileName() -> String {
        "match AppStore \(AppInfo.appIdentifier)"
    }
}
