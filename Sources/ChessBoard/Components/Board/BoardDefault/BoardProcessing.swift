//
//  File.swift
//
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

extension BoardDefault {
    /*
     Method run when user tap on cell.
     This is the main processing for board
     */
    func processing(_ cell: Cell) {
        if self.boardMode == .game {
            self.processingGame(cell)
        } else if self.boardMode == .analisys {
            self.processingAnalysis()
        }
    }
    
    func processingGame(_ cell: Cell) {
        if selectedCell == nil && cell.piece == nil {
            return
        }
        
        if cell.piece != nil && cell.piece?.color != playerColor {
            self.resetSelected()
            return
        }
        
        if selectedCell != nil && cell.piece?.color != playerColor && self.possibleCells.first(where: { c in c.id == cell.id }) == nil {
            self.resetSelected()
            return
        }
        
        if !possibleCells.isEmpty {
            let pc = possibleCells.first(where: { $0.id == cell.id })
            
            if pc != nil {
                for possibleCell in self.possibleCells {
                    possibleCell.unpossible()
                }
                    
                self.possibleCells.removeAll()
                    
                if pc != nil, selectedCell?.piece != nil {
                    _ = self.move(from: selectedCell!.location, to: cell.location)
                }
                
                self.resetSelected()
                return
            }
        }
         
        self.resetSelected()
        
        cell.selected.toggle()
        selectedCell = cell
        selectedIndex = LocationIndex(
            sidx: boardChars.firstIndex(of: cell.location.char)!,
            nidx: boardNumbers.firstIndex(of: cell.location.number)!
        )
        
        let possibleIndexes = self.possibleMoves(by: selectedCell!.piece!.type, location: selectedIndex!, color: selectedCell!.piece!.color)
        
        for possibleIndex in possibleIndexes {
            let possibleCell = self.cells[possibleIndex.nidx][possibleIndex.sidx]
            possibleCells.append(possibleCell)
            
            possibleCell.possible.toggle()
        }
    }
    
    func processingAnalysis() {}
    
    func resetSelected() {
        selectedCell?.selected.toggle()
        selectedCell = nil
        selectedIndex = nil
        
        for pc in possibleCells {
            pc.selected = false
            pc.possible = false
        }
        
        self.possibleCells.removeAll()
    }
}
