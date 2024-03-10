//
//  RookRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func rookPossibleMoves(_ location: LocationIndex, _ color: PieceColor)-> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        var possibleNumberIndex = nidx
        while possibleNumberIndex < 8 {
            possibleNumberIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, sidx, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        while possibleNumberIndex > -1 {
            possibleNumberIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, sidx, possibleNumberIndex) {
                break
            }
        }
        
        var possibleCharIndex = sidx
        while possibleCharIndex > -1 {
            possibleCharIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, nidx) {
                break
            }
        }
        
        possibleCharIndex = sidx
        while possibleCharIndex < 8 {
            possibleCharIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, nidx) {
                break
            }
        }
        
        return possibleMoves
    }
}
