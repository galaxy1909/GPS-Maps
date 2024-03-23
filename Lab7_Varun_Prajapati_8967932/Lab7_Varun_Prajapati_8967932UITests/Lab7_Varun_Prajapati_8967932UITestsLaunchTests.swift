//
//  Lab7_Varun_Prajapati_8967932UITestsLaunchTests.swift
//  Lab7_Varun_Prajapati_8967932UITests
//
//  Created by user237779 on 3/15/24.
//

import XCTest

final class Lab7_Varun_Prajapati_8967932UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
