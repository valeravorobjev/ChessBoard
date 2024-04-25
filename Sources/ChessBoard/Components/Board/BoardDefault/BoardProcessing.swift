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
    internal func processing(cell: Cell) -> Void {
        
        if self.boardMode == .game {
            processingGame(cell)
        } else if self.boardMode == .analisys {
            processingAnalysis()
        }
        
    }
    
    internal func processingGame(_ cell: Cell) -> Void {
        
        if !possibleCells.isEmpty {
            let pc = possibleCells.first(where: {$0.id == cell.id})
            
//            for possibleCell in self.possibleCells {
//                possibleCell.unpossible()
//            }
            
            self.possibleCells.removeAll()
            
            if pc != nil && selectedCell?.piece != nil {
                _ = self.move(from: selectedCell!.location, to: cell.location)
                
            }
            
        }
        
        resetSelected()
        
        if self.possibleCells.first(where: { c in
            c.id == cell.id}) == nil {
            return
        }
        
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
    
    internal func processingAnalysis() -> Void {
        
    }
    
    internal func resetSelected() -> Void {
        selectedCell = nil
        selectedIndex = nil
        
        self.possibleCells.removeAll()
    }
    
}
