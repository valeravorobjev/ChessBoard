//
//  PownRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func pownPossibleMoves(_ location: CLocation, _ color: PColor)-> [CLocation] {
        
        var possibles = [CLocation]()
        
        let numbers = self.playerColor == .white ? self.boardNumbers : self.boardNumbers.reversed()
        
        let yindex = numbers.firstIndex(of: location.y)!
        let xindex = self.boardChars.firstIndex(of: location.x)!
        
        var possible = CLocation(x: location.x, y: numbers[yindex + 1])
        
        if self.cells[possible.toStr()]?.piece == nil {
            possibles.append(possible)
        }
        
        if yindex == 1  {
            let prev = possible
            possible = CLocation(x: location.x, y: numbers[yindex + 2])
            
            if self.cells[prev.toStr()]?.piece == nil && self.cells[possible.toStr()]?.piece == nil {
                possibles.append(possible)
            }
        }
        
        if xindex < 7 {
            possible = CLocation(x: self.boardChars[xindex + 1], y: numbers[yindex + 1])
            let piece = self.cells[possible.toStr()]?.piece
            
            if piece != nil && piece?.color != color {
                possibles.append(possible)
            }
        }
        
        if xindex > 0 {
            possible = CLocation(x: self.boardChars[xindex - 1], y: numbers[yindex + 1])
            let piece = self.cells[possible.toStr()]?.piece
            
            if piece != nil && piece?.color != color {
                possibles.append(possible)
            }
        }
        
        return possibles
        
    }
}
