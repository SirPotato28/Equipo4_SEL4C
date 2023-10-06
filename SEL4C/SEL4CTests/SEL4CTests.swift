//
//  SEL4CTests.swift
//  SEL4CTests
//
//  Created by Andrew Williams on 25/08/23.
//

import XCTest
@testable import SEL4C

final class SEL4CTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCP_01() throws {
        // UI tests must launch the application that they test.
        var question = Question(id: 1, question_num: 12,activity: "Contestar pregunta",description: "Eres emprendedor?")
        XCTAssertNotNil(question)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
