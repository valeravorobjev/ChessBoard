//
//  PieceMove.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension BoardDefault: BoardMove {
    
    func move(from: LocationCell, to: LocationCell) -> MoveReport {
        
        let fromCell = getCellByLocationCell(from)
        let toCell = getCellByLocationCell(to)
        
        let mv = MoveReport(oldLoc: from, newLoc: to, ownPiece: fromCell.piece!, targetPiece: toCell.piece)
        
        let tmp = fromCell.piece!
        
        fromCell.removePiece()
        toCell.setPiece(tmp.type, tmp.color)
        
        return mv
    }
    
    private func getCellByLocationCell(_ lc: LocationCell) -> Cell {
        
        let li = convertLCtoLI(lc)
        
        return cells[li.nidx][li.sidx]
    }
}
