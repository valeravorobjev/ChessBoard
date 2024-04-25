//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import SwiftUI

public class Board: ObservableObject {
    internal private(set) var selectedCell: Cell? = nil
    internal private(set) var possibleCells: [Cell] = []
    internal private(set) var selectedIndex: LocationIndex? = nil
    
    internal var rotated: Bool = false
    internal var boardNumbers: [Int] = [8,7,6,5,4,3,2,1]
    internal var boardChars: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    internal private(set) var boardMode: BoardMode = .game
    internal private(set) var playerColor: PieceColor = .white
    internal private(set) var beginNumberIndex = 7
    internal private(set) var endNumberIndex = 0
    internal private(set) var beginCharIndex = 0
    internal private(set) var endCharIndex = 7
    
    @Published var cells: [[Cell]] = []
    
    public init(boardMode: BoardMode = .game, playerColor: PieceColor = .white) {
        
        if playerColor == .black && !rotated {
            boardNumbers.reverse()
        }
        
        if playerColor == .white && rotated {
            boardNumbers.reverse()
        }
        
        for numberIndex in 0..<8 {
            var rowCells = [Cell]()
            for charIndex in 0..<8 {
                let color = self.cellColor(charIndex, numberIndex)
                let location = self.cellCoord(charIndex, numberIndex)
                let show = self.cellCoordShow(charIndex, numberIndex)
                
                let cell = Cell(color: color, location: location, show: show)
                rowCells.append(cell)
            }
            cells.append(rowCells)
        }
        
    }
    
    private func cellCoordShow(_ charIndex: Int, _ numberIndex: Int, _ all: Bool = false) -> LocationShow {
        var charShow = false
        var numberShow = false
        
        if all {
            return LocationShow(charShow: true, numberShow: true)
        }
        
        if (playerColor == .white && numberIndex == 7) || (playerColor == .black && numberIndex == 0) {
            charShow = true
        }
        
        
        if (playerColor == .white && charIndex == 0) || (playerColor == .black && charIndex == 7){
            numberShow = true
        }
        
        return LocationShow(charShow: charShow, numberShow: numberShow)
    }
    
    private func cellColor(_ charIndex: Int, _ numberIndex: Int) -> PieceColor {
        var color: PieceColor = self.playerColor
        
        if (charIndex + numberIndex) % 2 != 0 {
            color = color.toggle()
        }
        
        return color
    }
    
    internal func cellCoord(_ charIndex: Int, _ numberIndex: Int) -> LocationCell {
        return LocationCell(char: boardChars[charIndex], number: boardNumbers[numberIndex])
    }
    
    internal func selectCell(cell: Cell) -> Void {
        
        if !possibleCells.isEmpty {
            let pc = possibleCells.first(where: {$0.id == cell.id})
            
            for possibleCell in self.possibleCells {
                possibleCell.unpossible()
            }
            
            self.possibleCells.removeAll()
            
            if pc != nil && selectedCell?.piece != nil {
                _ = self.move(from: selectedCell!, to: cell)
                
            }
            
        }
        
        if cell.piece == nil || (self.boardMode != .analisys && cell.piece?.color != self.playerColor) {
            selectedCell?.selected = false
            selectedCell = nil
            selectedIndex = nil
            return
        }
        
        if cell.piece != nil && cell.id == selectedCell?.id {
            selectedCell!.selected = false
            selectedCell = nil
            selectedIndex = nil
            return
        }
        
        selectedCell?.selected = false
        cell.selected.toggle()
        selectedCell = cell
        selectedIndex = LocationIndex(sidx: boardChars.firstIndex(of: cell.location.char)!, nidx: boardNumbers.firstIndex(of: cell.location.number)!)
        
        let possibleIndexes = self.possibleMoves(by: selectedCell!.piece!.type, location: selectedIndex!, color: selectedCell!.piece!.color)
        
        for possibleIndex in possibleIndexes {
            let possibleCell = self.cells[possibleIndex.nidx][possibleIndex.sidx]
            possibleCells.append(possibleCell)
            
            possibleCell.possible.toggle()
        }
    }
    
    public func clearBoard() -> Void {
        self.selectedCell = nil
        self.possibleCells.removeAll()
        
        
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
        cells[numberIndex0W][6].setPiece(.knight,.white)
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
    
    public func setBoardMode(mode: BoardMode) -> Void {
        self.boardMode = mode
    }
    
    public func setPlayerColor(color: PieceColor) -> Void {
        self.playerColor = color
    }
    
    public func rotateBoard() -> Void {
        
        self.selectedCell?.unselected()
        self.selectedCell = nil
        
        for c in self.possibleCells {
            c.unpossible()
        }
        self.possibleCells.removeAll()
        
        for i in 0..<4 {
            for j in 0..<8 {
                let tmp = cells[self.boardNumbers.count - (i+1)][j]
                cells[self.boardNumbers.count - (i+1)][j] = cells[i][j]
                cells[i][j] = tmp
            }
        }

    }
}
