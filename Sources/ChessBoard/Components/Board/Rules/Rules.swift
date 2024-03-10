//
//  Rules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 04.01.2024.
//

import Foundation

extension Board {
    
    func possibleMoves(by: PieceType, location: LocationIndex, color: PieceColor) -> [LocationIndex] {
        
        var possibles: [LocationIndex] = []
        
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
    
    func possibleMove(numbers: [Int], possibleMoves: inout [LocationIndex], _ color: PieceColor , _ sidx: Int, _ nidx: Int) -> Bool {
        
        if sidx > endCharIndex || sidx < beginCharIndex || nidx > endNumberIndex || nidx < beginNumberIndex {
            return false
        }
        
        let possible = LocationIndex(sidx: sidx, nidx: nidx)
        let cell = self.cells[nidx][sidx]
        
        if cell.piece == nil {
            possibleMoves.append(possible)
            return true
        }
        else if cell.piece != nil && cell.piece?.color != color {
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
            return self.boardNumbers.last!
        }
        
        return self.boardNumbers.first!
    }
    
    func lessOrEqualsEnd(_ nidx: Int) -> Bool {
        
        if self.playerColor == .white {
            
            if !rotated && nidx >= self.boardNumbers.last! {
                return true
            } else if rotated && nidx <= self.boardNumbers.last! {
                return false
            }
                
            
        }
        
        if self.playerColor == .black {
            
        }
    
        
        return false
    }
    
    func nexStepChar(_ sidx: Int, _ steps: Int) -> Int {
        return sidx + steps
    }
    
    func backStepChar(_ sidx: Int, _ steps: Int) -> Int {
        return sidx - steps
    }
    
}
