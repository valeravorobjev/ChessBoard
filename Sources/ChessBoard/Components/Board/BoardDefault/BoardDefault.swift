//
//  File.swift
//
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import SwiftUI

public class BoardDefault: BoardCommon {
    var selectedCell: Cell? = nil
    var possibleCells: [Cell] = []
    var selectedIndex: LocationIndex? = nil
    
    public var rotated: Bool = false
    public var boardNumbers: [Int] = [8, 7, 6, 5, 4, 3, 2, 1]
    public var boardChars: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    public private(set) var boardMode: BoardMode = .game
    public private(set) var playerColor: PieceColor = .white
    public private(set) var beginNumberIndex = 7
    public private(set) var endNumberIndex = 0
    public private(set) var beginCharIndex = 0
    public private(set) var endCharIndex = 7
    
    @Published public var cells: [[Cell]] = []
    
    public required init(boardMode: BoardMode = .game, playerColor: PieceColor = .white) {
        if playerColor == .black && !rotated {
            boardNumbers.reverse()
        }
        
        if playerColor == .white && rotated {
            boardNumbers.reverse()
        }
        
        for numberIndex in 0..<8 {
            var rowCells = [Cell]()
            for charIndex in 0..<8 {
                let color = cellColor(charIndex, numberIndex)
                let location = cellCoord(charIndex, numberIndex)
                let show = showCellCoords(charIndex, numberIndex)
                
                let cell = Cell(color: color, location: location, show: show)
                rowCells.append(cell)
            }
            cells.append(rowCells)
        }
    }
    
    func showCellCoords(_ charIndex: Int, _ numberIndex: Int, _ all: Bool = false) -> LocationShow {
        var charShow = false
        var numberShow = false
        
        if all {
            return LocationShow(charShow: true, numberShow: true)
        }
        
        if (playerColor == .white && numberIndex == 7) || (playerColor == .black && numberIndex == 0) {
            charShow = true
        }
        
        if (playerColor == .white && charIndex == 0) || (playerColor == .black && charIndex == 7) {
            numberShow = true
        }
        
        return LocationShow(charShow: charShow, numberShow: numberShow)
    }
    
    func cellColor(_ charIndex: Int, _ numberIndex: Int) -> PieceColor {
        var color: PieceColor = playerColor
        
        if (charIndex + numberIndex) % 2 != 0 {
            color = color.toggle()
        }
        
        return color
    }
    
    func cellCoord(_ charIndex: Int, _ numberIndex: Int) -> LocationCell {
        return LocationCell(boardChars[charIndex], boardNumbers[numberIndex])
    }
    
    public func clearBoard() {
        selectedCell = nil
        possibleCells.removeAll()
        
        for row in cells {
            for cell in row {
                cell.unpossible()
                cell.removePiece()
                cell.unselected()
            }
        }
    }
    
    public func initBoard() {
        clearBoard()
        
        let numberIndex0W = boardNumbers.firstIndex(of: boardNumbers.min()!)!
        let numberIndex1W = boardNumbers.firstIndex(of: boardNumbers.min()! + 1)!
        let numberIndex7B = boardNumbers.firstIndex(of: boardNumbers.max()!)!
        let numberIndex6B = boardNumbers.firstIndex(of: boardNumbers.max()! - 1)!
        
        cells[numberIndex0W][0].setPiece(.rook, .white)
        cells[numberIndex0W][1].setPiece(.knight, .white)
        cells[numberIndex0W][2].setPiece(.bishop, .white)
        cells[numberIndex0W][3].setPiece(.queen, .white)
        cells[numberIndex0W][4].setPiece(.king, .white)
        cells[numberIndex0W][5].setPiece(.bishop, .white)
        cells[numberIndex0W][6].setPiece(.knight, .white)
        cells[numberIndex0W][7].setPiece(.rook, .white)
        
        cells[numberIndex1W][0].setPiece(.pown, .white)
        cells[numberIndex1W][1].setPiece(.pown, .white)
        cells[numberIndex1W][2].setPiece(.pown, .white)
        cells[numberIndex1W][3].setPiece(.pown, .white)
        cells[numberIndex1W][4].setPiece(.pown, .white)
        cells[numberIndex1W][5].setPiece(.pown, .white)
        cells[numberIndex1W][6].setPiece(.pown, .white)
        cells[numberIndex1W][7].setPiece(.pown, .white)
        
        cells[numberIndex7B][0].setPiece(.rook, .black)
        cells[numberIndex7B][1].setPiece(.knight, .black)
        cells[numberIndex7B][2].setPiece(.bishop, .black)
        cells[numberIndex7B][3].setPiece(.queen, .black)
        cells[numberIndex7B][4].setPiece(.king, .black)
        cells[numberIndex7B][5].setPiece(.bishop, .black)
        cells[numberIndex7B][6].setPiece(.knight, .black)
        cells[numberIndex7B][7].setPiece(.rook, .black)
        
        cells[numberIndex6B][0].setPiece(.pown, .black)
        cells[numberIndex6B][1].setPiece(.pown, .black)
        cells[numberIndex6B][2].setPiece(.pown, .black)
        cells[numberIndex6B][3].setPiece(.pown, .black)
        cells[numberIndex6B][4].setPiece(.pown, .black)
        cells[numberIndex6B][5].setPiece(.pown, .black)
        cells[numberIndex6B][6].setPiece(.pown, .black)
        cells[numberIndex6B][7].setPiece(.pown, .black)
    }
    
    public func setBoardMode(mode: BoardMode) {
        boardMode = mode
    }
    
    public func setPlayerColor(color: PieceColor) {
        playerColor = color
    }
    
    public func rotateBoard() {
        selectedCell?.unselected()
        selectedCell = nil
        
        for c in possibleCells {
            c.unpossible()
        }
        possibleCells.removeAll()
        
        for i in 0..<4 {
            for j in 0..<8 {
                let tmp = cells[boardNumbers.count - (i + 1)][j]
                cells[boardNumbers.count - (i + 1)][j] = cells[i][j]
                cells[i][j] = tmp
            }
        }
    }
    
    public func getCell(_ location: LocationCell) -> Cell {
        let li = convertLCtoLI(location)
        
        return cells[li.nidx][li.sidx]
    }
}
