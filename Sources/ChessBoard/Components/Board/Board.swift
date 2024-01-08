//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import SwiftUI

class Board: ObservableObject {
    private var selectedCell: Cell? = nil
    private var possibleCells: [Cell] = []
    
    let boardNumbers: [Int] = [1,2,3,4,5,6,7,8]
    let boardChars: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    var boardMode: BoardMode = .game
    
    @Published var playerColor: PColor = .black
    @Published var cells: Dictionary<String, Cell> = Dictionary<String, Cell>()
    
    init() {
        for i in 0..<8 {
            for j in 0..<8{
                let color = self.cellColor(i, j)
                let scoord = self.cellCoord(i,j)
                let show = self.cellCoordShow(i, j)
                
                let cell = Cell(color: color, scoord: scoord, show: show)
                
                cells[scoord] = cell
            }
        }
    
    }
    
    func selectCell(cell: Cell) -> Void {
        
        if !possibleCells.isEmpty {
            let pc = possibleCells.first(where: {$0.id == cell.id})
            
            for possibleCell in self.possibleCells {
                possibleCell.possible.toggle()
            }
            
            self.possibleCells.removeAll()
            
            if pc != nil && selectedCell?.piece != nil {
                let cmove = self.move(from: selectedCell!, to: cell)
                
            }
            
        }
        
        if cell.piece == nil || (self.boardMode != .analisys && cell.piece?.color != self.playerColor) {
            selectedCell?.selected = false
            selectedCell = nil
            return
        }
        
        if cell.piece != nil && cell.id == selectedCell?.id {
            selectedCell!.selected = false
            selectedCell = nil
            return
        }
        
        selectedCell?.selected = false
        cell.selected.toggle()
        selectedCell = cell
        
        let possibleCoords = self.possibleMoves(by: selectedCell!.piece!.type, location: selectedCell!.location, color: selectedCell!.piece!.color)
        
        for possibleCoord in possibleCoords {
            let possibleCell = self.cells[possibleCoord.toStr()]!
            possibleCells.append(possibleCell)
            
            possibleCell.possible.toggle()
        }
    }
    
    func cellCoord(_ i: Int, _ j: Int) -> String {
        let numbers = self.playerColor == .white ? boardNumbers.reversed() : boardNumbers
        return "\(boardChars[j])\(numbers[i])"
    }
    
    private func cellCoordShow(_ x: Int, _ y: Int, _ all: Bool = false) -> LShow {
        var xshow = false
        var yshow = false
        
        if all {
            return LShow(xshow: true, yshow: true)
        }
        
        if x == 7 {
            xshow = true
        }
        
        if y == 0 {
            yshow = true
        }
        
        return LShow(xshow: xshow, yshow: yshow)
    }
    
    private func cellColor(_ i: Int, _ j: Int) -> PColor {
        var color: PColor = self.playerColor
        
        if (i + j) % 2 != 0 {
            color = color.toggle()
        }
        
        return color
    }
    
    func initBoard() {
        cells["a2"]?.setPiece(.pown, .white)
        cells["b2"]?.setPiece(.pown, .white)
        cells["c2"]?.setPiece(.pown, .white)
        cells["d2"]?.setPiece(.pown, .white)
        cells["e2"]?.setPiece(.pown, .white)
        cells["f2"]?.setPiece(.pown, .white)
        cells["g2"]?.setPiece(.pown, .white)
        cells["h2"]?.setPiece(.pown, .white)
        
        cells["b4"]?.setPiece(.rook, .white)
        cells["e3"]?.setPiece(.knight, .white)
        cells["c1"]?.setPiece(.bishop, .white)
        cells["d1"]?.setPiece(.queen, .white)
        cells["e1"]?.setPiece(.king, .white)
        cells["f1"]?.setPiece(.bishop, .white)
        cells["g1"]?.setPiece(.knight, .white)
        cells["h1"]?.setPiece(.rook, .white)
        
        cells["a7"]?.setPiece(.pown, .black)
        cells["b7"]?.setPiece(.pown, .black)
        cells["c7"]?.setPiece(.pown, .black)
        cells["d7"]?.setPiece(.pown, .black)
        cells["e7"]?.setPiece(.pown, .black)
        cells["f7"]?.setPiece(.pown, .black)
        cells["g7"]?.setPiece(.pown, .black)
        cells["h7"]?.setPiece(.pown, .black)
        
        cells["a8"]?.setPiece(.rook, .black)
        cells["b8"]?.setPiece(.knight, .black)
        cells["c8"]?.setPiece(.bishop, .black)
        cells["d8"]?.setPiece(.queen, .black)
        cells["e4"]?.setPiece(.king, .black)
        cells["f8"]?.setPiece(.bishop, .black)
        cells["g8"]?.setPiece(.knight, .black)
        cells["h8"]?.setPiece(.rook, .black)
    }
    
    func initBoard(pcoords: [PCoord]) {
        for pcoord in pcoords {
            cells[pcoord.scoord]?.setPiece(pcoord.type, pcoord.color)
        }
    }
}
