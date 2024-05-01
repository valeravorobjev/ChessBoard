//
//  ShadowBoardTests.swift
//
//
//  Created by Валерий Воробьев on 30.04.2024.
//

@testable import ChessBoard
import XCTest

final class ShadowBoardTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardWightStartEndIndexes() throws {
        let shadowBoard: ShadowBoard = .init(playerColor: .white, boardMode: .game)
        shadowBoard.createBoard8x8()

        let numberStartIndex: Int = shadowBoard.numberStartIndex
        assert(numberStartIndex == 7)
        assert(shadowBoard.boardNumbers[numberStartIndex] == 1)

        let numberEndIndex = shadowBoard.numberEndIndex
        assert(numberEndIndex == 0)
        assert(shadowBoard.boardNumbers[numberEndIndex] == 8)

        let charStartIndex = shadowBoard.charStartIndex
        assert(charStartIndex == 0)
        assert(shadowBoard.boardChars[charStartIndex] == "a")

        let charEndIndex = shadowBoard.charEndIndex
        assert(charEndIndex == 7)
        assert(shadowBoard.boardChars[charEndIndex] == "h")
    }

    func testBoardWightRotatedStartEndIndexes() throws {
        let shadowBoard: ShadowBoard = .init(playerColor: .white, boardMode: .game)
        shadowBoard.createBoard8x8()
        shadowBoard.rotate()

        let numberStartIndex = shadowBoard.numberStartIndex
        assert(numberStartIndex == 0)
        assert(shadowBoard.boardNumbers[numberStartIndex] == 1)

        let numberEndIndex = shadowBoard.numberEndIndex
        assert(numberEndIndex == 7)
        assert(shadowBoard.boardNumbers[numberEndIndex] == 8)

        let charStartIndex = shadowBoard.charStartIndex
        assert(charStartIndex == 7)
        assert(shadowBoard.boardChars[charStartIndex] == "a")

        let charEndIndex = shadowBoard.charEndIndex
        assert(charEndIndex == 0)
        assert(shadowBoard.boardChars[charEndIndex] == "h")
    }

    func testBoardBlackStartEndIndexes() throws {
        let shadowBoard: ShadowBoard = .init(playerColor: .black, boardMode: .game)
        shadowBoard.createBoard8x8()

        let numberStartIndex: Int = shadowBoard.numberStartIndex
        assert(numberStartIndex == 0)
        assert(shadowBoard.boardNumbers[numberStartIndex] == 8)

        let numberEndIndex = shadowBoard.numberEndIndex
        assert(numberEndIndex == 7)
        assert(shadowBoard.boardNumbers[numberEndIndex] == 1)

        let charStartIndex = shadowBoard.charStartIndex
        assert(charStartIndex == 7)
        assert(shadowBoard.boardChars[charStartIndex] == "h")

        let charEndIndex = shadowBoard.charEndIndex
        assert(charEndIndex == 0)
        assert(shadowBoard.boardChars[charEndIndex] == "a")
    }

    func testBoardBlackRotatedStartEndIndexes() throws {
        let shadowBoard: ShadowBoard = .init(playerColor: .black, boardMode: .game)
        shadowBoard.createBoard8x8()
        shadowBoard.rotate()

        let numberStartIndex: Int = shadowBoard.numberStartIndex
        assert(numberStartIndex == 7)
        assert(shadowBoard.boardNumbers[numberStartIndex] == 8)

        let numberEndIndex = shadowBoard.numberEndIndex
        assert(numberEndIndex == 0)
        assert(shadowBoard.boardNumbers[numberEndIndex] == 1)

        let charStartIndex = shadowBoard.charStartIndex
        assert(charStartIndex == 0)
        assert(shadowBoard.boardChars[charStartIndex] == "h")

        let charEndIndex = shadowBoard.charEndIndex
        assert(charEndIndex == 7)
        assert(shadowBoard.boardChars[charEndIndex] == "a")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
