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
            
        // if cell is null, pawn can be moved one step
        if self.board[possibleOne.nidx][possibleOne.sidx] == nil {
            possibles.append(possibleOne)
                
            if nidx == self.pownStartNIdx() {
                let possibleTwo = LocationIndex(sidx: possibleOne.sidx, nidx: nextStepNumber(possibleOne.nidx, 1))
                    
                // if cell is null, pawn can be moved one step
                if self.board[possibleTwo.nidx][possibleTwo.sidx] == nil {
                    possibles.append(possibleTwo)
                }
            }
        }
        
        let nextPossibleUpStep = nextStepNumber(nidx, 1)
        
        let possibleUpRight = LocationIndex(sidx: nexStepChar(sidx, 1), nidx: nextPossibleUpStep)
        let possibleUpLeft = LocationIndex(sidx: backStepChar(sidx, 1), nidx: nextPossibleUpStep)
        
        if possibleUpRight.sidx <= boardChars.count - 1 {
            let piece = self.board[possibleUpRight.nidx][possibleUpRight.sidx]
            
            if piece != nil && piece?.color != playerColor {
                possibles.append(possibleUpRight)
            }
        }
        
        if possibleUpLeft.sidx >= 0 {
            let piece = self.board[possibleUpLeft.nidx][possibleUpLeft.sidx]
            
            if piece != nil && piece?.color != playerColor {
                possibles.append(possibleUpLeft)
            }
        }
        
        return possibles
    }
    
    func pownStartNIdx() -> Int {
        if self.playerColor == .white {
            if !self.rotated {
                return 6
            } else {
                return 1
            }
        }
        
        return 1
    }
}
