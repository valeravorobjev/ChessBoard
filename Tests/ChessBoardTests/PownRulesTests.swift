//
//  PownRulesTests.swift
//
//
//  Created by Валерий Воробьев on 30.04.2024.
//

@testable import ChessBoard
import XCTest

final class PownRulesTests: XCTestCase {
    let shadowBoard: ShadowBoard = .init(playerColor: .white, boardMode: .game)

    override func setUpWithError() throws {
        shadowBoard.createBoard8x8()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
