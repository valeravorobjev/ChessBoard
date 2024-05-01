//
//  PownRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension ShadowBoard {
    func pownPossibleMoves(_ location: LocationIndex) -> [LocationIndex] {
        var possibles = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        // Check whether the pawn can rotate one or two moves
        if !lessNumberEndIndex(nidx) {
            return possibles
        }
        
        let possibleOne = LocationIndex(sidx: sidx, nidx: nextStepNumber(nidx, 1))
        
        if self.board[possibleOne.nidx][possibleOne.sidx] == nil {
            _ = possibleMove(possibleMoves: &possibles, possibleOne.sidx, possibleOne.nidx)
        }
            
        if nidx == self.pownStartNIdx() {
            let possibleTwo = LocationIndex(sidx: possibleOne.sidx, nidx: nextStepNumber(possibleOne.nidx, 1))
            
            if self.board[possibleTwo.nidx][possibleTwo.sidx] == nil {
                _ = possibleMove(possibleMoves: &possibles, possibleTwo.sidx, possibleTwo.nidx)
            }
        }
        
        let possibleUpRight = LocationIndex(sidx: nexStepChar(sidx, 1), nidx: possibleOne.nidx)
        let possibleUpLeft = LocationIndex(sidx: backStepChar(sidx, 1), nidx: possibleOne.nidx)
        
        if lessOrEqualNumberEndIndex(possibleUpRight.nidx) && biggerOrEqualNumberStartIndex(possibleUpRight.nidx) && lessOrEqualCharEndIndex(possibleUpRight.sidx) {
            if self.board[possibleUpRight.nidx][possibleUpRight.sidx] != nil
                && self.board[possibleUpRight.nidx][possibleUpRight.sidx]?.color != playerColor
            {
                _ = possibleMove(possibleMoves: &possibles, possibleUpRight.sidx, possibleUpRight.nidx)
            }
        }
        
        if lessOrEqualNumberEndIndex(possibleUpLeft.nidx) && biggerOrEqualNumberStartIndex(possibleUpLeft.nidx) && biggerOrEqualCharStartIndex(possibleUpLeft.sidx) {
            if self.board[possibleUpLeft.nidx][possibleUpLeft.sidx] != nil
                && self.board[possibleUpLeft.nidx][possibleUpLeft.sidx]?.color != playerColor
            {
                _ = possibleMove(possibleMoves: &possibles, possibleUpLeft.sidx, possibleUpLeft.nidx)
            }
        }
        
        return possibles
    }
    
    func pownStartNIdx() -> Int {
        if self.playerColor == .white {
            if !self.rotated {
                return numberStartIndex - 1
            } else {
                return numberStartIndex + 1
            }
        } else {
            if !self.rotated {
                return numberStartIndex + 1
            } else {
                return numberStartIndex - 1
            }
        }
    }
}
