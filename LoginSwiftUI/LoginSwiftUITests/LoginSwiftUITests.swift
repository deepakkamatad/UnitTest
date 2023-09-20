//
//  LoginSwiftUITests.swift
//  LoginSwiftUITests
//
//  Created by Deepak Basavaraj Kamatad on 14/09/23.
//

import XCTest
@testable import LoginSwiftUI

final class LoginSwiftUITests: XCTestCase {
    var viewModel: LoginViewModel!

        override func setUp() {
            super.setUp()
            viewModel = LoginViewModel()
        }

        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }

        func testSuccessfulLogin() {
            let expectation = XCTestExpectation(description: "Login success")
            viewModel.getToken(username: "atistagetest", password: "Password1") { success in
                XCTAssertTrue(success, "Login should be successful")
                XCTAssertNotNil(TokenResponse.self)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
        }

        func testFailedLogin() {
            let expectation = XCTestExpectation(description: "Login failure")
            viewModel.getToken(username: "invalidUser", password: "invalidPassword") { success in
                XCTAssertFalse(success, "Login should fail with incorrect credentials")
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
        }

}
