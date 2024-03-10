//
//  PownRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func pownPossibleMoves(_ location: LocationIndex, _ color: PieceColor)-> [LocationIndex] {
        
        var possibles = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        // Check whether the pawn can rotate one or two moves
        if lessOrEqualsEnd(nidx) {
            let possibleOne = LocationIndex(sidx: sidx, nidx: nextStepNumber(nidx, 1))
            
            // if cell is null, pawn can be moved one step
            if self.cells[possibleOne.nidx][possibleOne.sidx].piece == nil {
                possibles.append(possibleOne)
                
                
                if nidx == pownStartNIdx() {
                    let possibleTwo = LocationIndex(sidx: possibleOne.sidx, nidx: nextStepNumber(possibleOne.nidx, 1))
                    
                    // if cell is null, pawn can be moved one step
                    if self.cells[possibleTwo.nidx][possibleTwo.sidx].piece == nil {
                        possibles.append(possibleTwo)
                    }
                }
                
            }
        }
        
        let nextPossibleUpStep = nextStepNumber(nidx, 1)
        if lessOrEqualsEnd(nextPossibleUpStep) {
            
            if sidx != endCharIndex {
                let possibleUpRight = LocationIndex(sidx: nexStepChar(sidx, 1), nidx: nextPossibleUpStep)
                let piece = self.cells[possibleUpRight.nidx][possibleUpRight.sidx].piece
                
                if piece != nil && piece?.color != color {
                    possibles.append(possibleUpRight)
                }
            }
            
            if sidx != beginCharIndex {
                let possibleUpLeft = LocationIndex(sidx: backStepChar(sidx, 1), nidx: nextPossibleUpStep)
                let piece = self.cells[possibleUpLeft.nidx][possibleUpLeft.sidx].piece
                
                if piece != nil && piece?.color != color {
                    possibles.append(possibleUpLeft)
                }
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
