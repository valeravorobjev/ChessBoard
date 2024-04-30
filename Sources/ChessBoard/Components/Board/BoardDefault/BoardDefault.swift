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
    
    private(set) var shadowBoard: ShadowBoard
    
    @Published public var cells: [[Cell]] = []
    
    public var boardNumbersCount: Int {
        return shadowBoard.boardNumbers.count
    }
    
    public var boardCharsCount: Int {
        return shadowBoard.boardChars.count
    }
    
    public required init(boardMode: BoardMode = .game, playerColor: PieceColor = .white) {
        shadowBoard = ShadowBoard(playerColor: playerColor, boardMode: boardMode)
        
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
        
        shadowBoard.clear()
    }
    
    public func initBoard() {
        shadowBoard.createBoard8x8()
        renderAllCells()
    }
    
    public func changeBoardMode(mode: BoardMode) {}
    
    public func changePlayer() {}
    
    public func rotateBoard() {
        selectedCell?.unselected()
        selectedCell = nil
        
        for c in possibleCells {
            c.unpossible()
        }
        possibleCells.removeAll()
        
        shadowBoard.rotate()
        
        renderAllCells()
    }
    
    public func getCell(_ location: LocationCell) -> Cell {
        let li = convertLCtoLI(location)
        
        return cells[li.nidx][li.sidx]
    }
    
    public func makeMove(from: LocationCell, to: LocationCell) -> MoveReport? {
        let fromLi = convertLCtoLI(from)
        let toLi = convertLCtoLI(to)
        
        _ = processing(cells[fromLi.nidx][fromLi.sidx])
        let moveReport = processing(cells[toLi.nidx][toLi.sidx])
        
        return moveReport
    }
    
    public func processing(_ cell: Cell) -> MoveReport? {
        var moveReport: MoveReport? = nil
        if shadowBoard.boardMode == .game {
            moveReport = processingGame(cell)
        } else if shadowBoard.boardMode == .analisys {
            processingAnalysis()
        }
        
        return moveReport
    }
    
    private func showCellCoords(_ charIndex: Int, _ numberIndex: Int, _ all: Bool = false) -> LocationShow {
        var charShow = false
        var numberShow = false
    
        if all {
            return LocationShow(charShow: true, numberShow: true)
        }
    
        if (shadowBoard.playerColor == .white && numberIndex == 7) || (shadowBoard.playerColor == .black && numberIndex == 0) {
            charShow = true
        }
    
        if (shadowBoard.playerColor == .white && charIndex == 0) || (shadowBoard.playerColor == .black && charIndex == 7) {
            numberShow = true
        }
    
        return LocationShow(charShow: charShow, numberShow: numberShow)
    }
    
    private func cellColor(_ charIndex: Int, _ numberIndex: Int) -> PieceColor {
        var color: PieceColor = shadowBoard.playerColor
        
        if (charIndex + numberIndex) % 2 != 0 {
            color = color.toggle()
        }
        
        return color
    }
    
    private func cellCoord(_ charIndex: Int, _ numberIndex: Int) -> LocationCell {
        return LocationCell(shadowBoard.boardChars[charIndex], shadowBoard.boardNumbers[numberIndex])
    }
    
    private func processingGame(_ cell: Cell) -> MoveReport? {
        let pieceOperationType = shadowBoard.checkPieceOperationType(location: convertLCtoLI(cell.location), possibles: possibleCells.map {
            convertLCtoLI($0.location)
        })
        
        switch pieceOperationType {
        case .Unknown:
            resetSelected()
            return nil
        case .Select:
            
            resetSelected()
            
            cell.selected.toggle()
            selectedCell = cell
            selectedIndex = LocationIndex(
                sidx: shadowBoard.boardChars.firstIndex(of: cell.location.char)!,
                nidx: shadowBoard.boardNumbers.firstIndex(of: cell.location.number)!
            )
            
            let possibleIndexes = shadowBoard.possibleMoves(by: selectedCell!.piece!.type, location: selectedIndex!)
            
            for possibleIndex in possibleIndexes {
                let possibleCell = cells[possibleIndex.nidx][possibleIndex.sidx]
                possibleCell.possible.toggle()
                possibleCells.append(possibleCell)
            }
            
            return nil
        case .Move:
            for possibleCell in possibleCells {
                possibleCell.unpossible()
            }

            possibleCells.removeAll()

            let moveReport: MoveReport? = move(from: selectedCell!.location, to: cell.location)
            
            resetSelected()
            return moveReport
        }
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
        
        let smr = shadowBoard.move(from: convertLCtoLI(from), to: convertLCtoLI(to))
        let mr = convertSMRtoMR(smr)
        
        let tmp = fromCell.piece!
        
        fromCell.removePiece()
        toCell.setPiece(tmp.type, tmp.color)
        
        return mr
    }
    
    private func renderAllCells() -> Void {
        for i in 0..<shadowBoard.boardNumbers.count {
            for j in 0..<shadowBoard.boardChars.count {
                let piece = shadowBoard.board[i][j]
                if piece == nil {
                    continue
                }
                
                cells[i][j].setPiece(piece!.type, piece!.color)
            }
        }
    }
    
    func convertLCtoLI(_ lc: LocationCell) -> LocationIndex {
        let sidx = shadowBoard.boardChars.firstIndex(of: lc.char)
        let nidx = shadowBoard.boardNumbers.firstIndex(of: lc.number)

        return LocationIndex(sidx: sidx!, nidx: nidx!)
    }
    
    func convertLItoLC(_ li: LocationIndex) -> LocationCell {
        let char = shadowBoard.boardChars[li.sidx]
        let number = shadowBoard.boardNumbers[li.nidx]
        
        return LocationCell(char, number)
    }
    
    func convertSMRtoMR(_ smr: ShadowMoveReport) -> MoveReport {
        return MoveReport(oldLoc: convertLItoLC(smr.oldLoc), newLoc: convertLItoLC(smr.newLoc), ownPiece: smr.ownPiece, targetPiece: smr.targetPiece, checkKing: smr.checkKing, checkMate: smr.checkMate)
    }
}
