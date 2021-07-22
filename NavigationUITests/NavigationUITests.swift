//
//  NavigationUITests.swift
//  NavigationUITests
//
//  Created by v.milchakova on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import XCTest

class NavigationUITests: XCTestCase {

    var app = XCUIApplication()

    open override func setUp() {
        super.setUp()
    }

    open override func tearDown() {
        super.tearDown()
    }

    override func record(_ issue: XCTIssue) {
        var issue = issue
        let debugMessage = "Дерево после падения: \(app.debugDescription)"
        print(debugMessage)
        issue.add(XCTAttachment(string: debugMessage))
        super.record(issue)
    }
    
    func testFeedOpened() throws {
        launchAndGoToFeed()
        
        XCTAssert(app.buttons["Open post"].exists)
    }
    
    func testPostAlert() throws {
        launchAndGoToFeed()
        
        goToAlert()
        
        let alert = app.alerts["Удалить пост?"]
        
        XCTAssert(alert.buttons["Отмена"].isHittable)
        XCTAssert(alert.buttons["Удалить"].isHittable)
    }
    
    func testPostAlertClosed() throws {
        launchAndGoToFeed()
        
        goToAlert()
        
        let alert = app.alerts["Удалить пост?"]
        
        alert.buttons["Удалить"].tap()
        
        XCTAssertFalse(alert.waitForExistence(timeout: 1))
    }

    func testProfileScreenOpened() throws {
        launchAndLogin()
        
        XCTAssert(app.tables.firstMatch.exists && app.tables.firstMatch.isHittable)
        XCTAssertEqual(app.tables.firstMatch.cells.count, 4)
    }
    
    func testPhotosScreenOpened() throws {
        launchAndLogin()
        
        XCTAssert(app.otherElements["Photos"].isHittable)
        app.otherElements["Photos"].buttons.firstMatch.tap()
        
        XCTAssertEqual(app.navigationBars.firstMatch.identifier, "Photo Gallery")
        XCTAssertEqual(app.collectionViews.firstMatch.cells.count, 15)
    }
    
    private func launchAndLogin() {
        app.launch()
        app.buttons["Profile"].tap()
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("test login")
        app.secureTextFields.firstMatch.tap()
        app.secureTextFields.firstMatch.typeText("test password")
        app.buttons["Log In"].tap()
        XCTAssert(app.otherElements["Hysterical Cat"].exists && app.otherElements["Hysterical Cat"].isHittable)
    }
    
    private func goToAlert() {
        app.buttons["Open post"].tap()
        app.buttons["Add post"].tap()
        
        XCTAssert(app.buttons["Add new post"].waitForExistence(timeout: 2))
        app.buttons["Add new post"].tap()
        
        let alert = app.alerts["Удалить пост?"]
        
        XCTAssert(alert.waitForExistence(timeout: 2))
    }
    
    private func launchAndGoToFeed() {
        app.launch()
        app.buttons["Feed"].tap()
    }
}
