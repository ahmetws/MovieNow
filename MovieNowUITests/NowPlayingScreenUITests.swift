//
//  NowPlayingScreenUITests.swift
//  MovieNowUITests
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import XCTest
import Quick
import Nimble
@testable import MovieNow

final class NowPlayingScreenUITests: QuickSpec {

    private static var nowPlayingScreen: XCUIElement {
        return XCUIApplication().tables["nowPlayingScreen"].firstMatch
    }

    override class func spec() {
        describe("NowPlaying Screen") {
            it("launched successfully") {
                let app = XCUIApplication()
                app.launch()

                XCTContext.runActivity(named: #function) { _ in
                    XCTAssertTrue(nowPlayingScreen.exists)
                }
            }
        }
    }
}
