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
    
    public func changeBoardMode(mode: BoardMode) {
        boardMode = mode
    }
    
    public func changePlayer() {
        playerColor = playerColor.toggle()
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
        
        boardNumbers.reverse()
        
        rotated = !rotated
    }
    
    public func getCell(_ location: LocationCell) -> Cell {
        let li = convertLCtoLI(location)
        
        return cells[li.nidx][li.sidx]
    }
    
    public func processing(_ cell: Cell) -> MoveReport? {
        var moveReport: MoveReport? = nil
        if boardMode == .game {
            moveReport = processingGame(cell)
        } else if boardMode == .analisys {
            processingAnalysis()
        }
        
        return moveReport
    }
    
    public func makeMove(from: LocationCell, to: LocationCell) -> MoveReport? {
        let fromLi = convertLCtoLI(from)
        let toLi = convertLCtoLI(to)
        
        _ = processing(cells[fromLi.nidx][fromLi.sidx])
        let moveReport = processing(cells[toLi.nidx][toLi.sidx])
        
        return moveReport
    }
    
    private func processingGame(_ cell: Cell) -> MoveReport? {
        if selectedCell == nil && cell.piece == nil {
            return nil
        }
        
        if selectedCell != nil && selectedCell?.id == cell.id {
            resetSelected()
            return nil
        }
        
        if cell.piece != nil && cell.piece?.color != playerColor && !cell.possible {
            resetSelected()
            return nil
        }
        
        if selectedCell != nil && cell.piece?.color != playerColor && possibleCells.first(where: { c in c.id == cell.id }) == nil {
            resetSelected()
            return nil
        }
        
        if !possibleCells.isEmpty {
            let pc = possibleCells.first(where: { $0.id == cell.id })

            if pc != nil {
                for possibleCell in possibleCells {
                    possibleCell.unpossible()
                }

                possibleCells.removeAll()

                var moveReport: MoveReport? = nil
                if pc != nil, selectedCell?.piece != nil {
                    moveReport = move(from: selectedCell!.location, to: cell.location)
                }

                resetSelected()
                return moveReport
            }
        }
         
        resetSelected()
        
        cell.selected.toggle()
        selectedCell = cell
        selectedIndex = LocationIndex(
            sidx: boardChars.firstIndex(of: cell.location.char)!,
            nidx: boardNumbers.firstIndex(of: cell.location.number)!
        )
        
        let possibleIndexes = possibleMoves(by: selectedCell!.piece!.type, location: selectedIndex!)
        
        for possibleIndex in possibleIndexes {
            let possibleCell = cells[possibleIndex.nidx][possibleIndex.sidx]
            possibleCell.possible.toggle()
            possibleCells.append(possibleCell)
        }
        
        return nil
    }
    
    private func processingAnalysis() {}
    
    private func resetSelected() {
        selectedCell?.selected = false
        selectedCell = nil
        selectedIndex = nil
        
        for pc in possibleCells {
            pc.selected = false
            pc.possible = false
        }
        
        possibleCells.removeAll()
    }
    
    private func getCellByLocationCell(_ lc: LocationCell) -> Cell {
        let li = convertLCtoLI(lc)
        
        return cells[li.nidx][li.sidx]
    }
    
    private func move(from: LocationCell, to: LocationCell) -> MoveReport {
        let fromCell = getCellByLocationCell(from)
        let toCell = getCellByLocationCell(to)
        
        let mv = MoveReport(oldLoc: from, newLoc: to, ownPiece: fromCell.piece!, targetPiece: toCell.piece)
        
        let tmp = fromCell.piece!
        
        fromCell.removePiece()
        toCell.setPiece(tmp.type, tmp.color)
        
        return mv
    }
}
