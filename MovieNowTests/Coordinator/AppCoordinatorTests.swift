//
//  AppCoordinatorTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Quick
import Nimble
import UIKit
@testable import MovieNow

final class AppCoordinatorTests: QuickSpec {

    override class func spec() {
        describe("AppCoordinator") {
            it("can not start successfully without window") {
                let coordinator = AppCoordinator(window: nil)
                coordinator.start()
                expect(coordinator.rootViewController).to(beNil())
            }

            it("starts successfully with window") {
                let coordinator = AppCoordinator(window: UIWindow())
                coordinator.start()
                expect(coordinator.rootViewController).toNot(beNil())
                expect(coordinator.rootViewController).to(beAKindOf(UINavigationController.self))
            }

        }
    }
}
