//
//  PieceMove.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension BoardMoveDefault {
    
    func move(from: Cell, to: Cell) -> MoveReport {
        let mv = MoveReport(oldLoc: from.location, newLoc: to.location, ownPiece: from.piece!, targetPiece: to.piece)
        
        let tmp = from.piece!
        
        from.removePiece()
        to.setPiece(tmp.type, tmp.color)
        
        return mv
    }
}
