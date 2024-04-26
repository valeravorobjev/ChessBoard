//
//  Rules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 04.01.2024.
//

import Foundation

extension BoardCommon {
    func possibleMoves(by: PieceType, location: LocationIndex) -> [LocationIndex] {
        var possibles: [LocationIndex] = []
        
        switch by {
        case .pown:
            possibles = self.pownPossibleMoves(location)
        case .rook:
            possibles = self.rookPossibleMoves(location)
        case .knight:
            possibles = self.knightPossibleMoves(location)
        case .bishop:
            possibles = self.bishopPossibleMoves(location)
        case .queen:
            possibles = self.queenPossibleMoves(location)
        case .king:
            possibles = self.kingPossibleMoves(location)
        }
        
        return possibles
    }
    
    func possibleMove(possibleMoves: inout [LocationIndex], _ sidx: Int, _ nidx: Int) -> Bool {
        if sidx < 0 || sidx >= boardChars.count || nidx < 0 || nidx >= boardNumbers.count {
            return false
        }
        
        let possible = LocationIndex(sidx: sidx, nidx: nidx)
        let cell = self.cells[nidx][sidx]
        
        if cell.piece == nil {
            possibleMoves.append(possible)
            return true
        } else if cell.piece != nil && cell.piece?.color != playerColor {
            possibleMoves.append(possible)
            return false
        }
        
        return false
    }
    
    func nextStepNumber(_ nidx: Int, _ steps: Int) -> Int {
        if self.playerColor == .white && !rotated {
            return nidx - steps
        }
        
        return nidx + steps
    }
    
    func endNIndex() -> Int {
        if self.playerColor == .white && !rotated {
            return self.boardNumbers.count - 1
        }
        
        return 0
    }
    
    func endSIndex() -> Int {
        if self.playerColor == .white && !rotated {
            return self.boardChars.count - 1
        }
        
        return 0
    }
    
    func lessNumberEndIndex(_ nidx: Int) -> Bool {
        if self.playerColor == .white {
            if !rotated && nidx > 0 {
                return true
            } else if rotated && nidx < self.boardNumbers.count - 1 {
                return true
            } else {
                return false
            }
        }
        
        if self.playerColor == .black {}
    
        return false
    }
    
    func nexStepChar(_ sidx: Int, _ steps: Int) -> Int {
        return sidx + steps
    }
    
    func backStepChar(_ sidx: Int, _ steps: Int) -> Int {
        return sidx - steps
    }
}
