//
//  BoardTests.swift
//  
//
//  Created by Валерий Воробьев on 11.03.2024.
//

import XCTest
@testable import ChessBoard

final class BoardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitBoard() throws {
        let board = Board(boardMode: .game, playerColor: .white)
        board.initBoard()
    }
    
    func testSelectCell() throws {
        let board = Board(boardMode: .game, playerColor: .white)
        
        board.initBoard()
        board.selectCell(cell:board.cells[2][1])
    }
    
    func testMovePown() throws {
        let board = Board(boardMode: .game, playerColor: .white)
        board.initBoard()
        
        board.selectCell(cell: board.cells[6][2])
        
        assert(board.selectedCell != nil, "selected cell can't be nil")
        assert(board.selectedCell?.piece != nil, "selected cell must have piece pown")
        assert(board.selectedCell?.location.number == 2, "selected cell must have number = 2")
        assert(board.selectedCell?.location.char == "c", "selected cell must have char = c")
        
        assert(board.possibleCells.count == 2, "selected pown on start position must have 2 possibles cell")
        assert(board.possibleCells[0].location.char == "c" && board.possibleCells[0].location.number == 3, "possible cell must be c3")
        assert(board.possibleCells[1].location.char == "c" && board.possibleCells[1].location.number == 4, "possible cell must be c4")
        
        
        
        board.selectCell(cell: board.cells[4][2])
        assert(board.selectedCell?.location.toStr() == "c4", "pown must be on c4 cell")
        
        board.selectCell(cell: board.cells[3][2])
        assert(board.selectedCell?.location.toStr() == "c5", "pown must be on c5 cell")
        
        board.selectCell(cell: board.cells[2][2])
        assert(board.selectedCell?.location.toStr() == "c6", "pown must be on c6 cell")
        
        board.selectCell(cell: board.cells[1][1])
        assert(board.selectedCell?.location.toStr() == "b7", "pown must be on b7 cell")
        
        board.selectCell(cell: board.cells[0][2])
        assert(board.selectedCell?.location.toStr() == "c8", "pown must be on c8 cell")
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}