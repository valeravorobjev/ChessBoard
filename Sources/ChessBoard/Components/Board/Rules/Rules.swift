//
//  Rules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 04.01.2024.
//

import Foundation

extension Board {
    
    func possibleMoves(by: TPiece, location: CLocation, color: PColor) -> [CLocation] {
        
        var possibles: [CLocation] = []
        
        switch by {
        case .pown:
            possibles = self.pownPossibleMoves(location, color)
        case .rook:
            possibles = self.rookPossibleMoves(location, color)
        case .knight:
            possibles = self.knightPossibleMoves(location, color)
        case .bishop:
            possibles = self.bishopPossibleMoves(location, color)
        case .queen:
            possibles = self.queenPossibleMoves(location, color)
        case .king:
            possibles = self.kingPossibleMoves(location, color)
            
        }
        
        return possibles
    }
    
    func possibleMove(numbers: [Int], possibleMoves: inout [CLocation], _ color: PColor , _ xindex: Int, _ yindex: Int) -> Bool {
        
        if xindex > 7 || xindex < 0 || yindex > 7 || yindex < 0 {
            return false
        }
        
        let possible = CLocation(x: self.boardChars[xindex], y: numbers[yindex])
        let cell = self.cells[possible.toStr()]
        
        if cell?.piece == nil {
            possibleMoves.append(possible)
            return true
        }
        else if cell?.piece != nil && cell?.piece?.color != color {
            possibleMoves.append(possible)
            return false
        }
        
        return false
    }
    
}
