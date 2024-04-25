//
//  KnightRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension BoardCommon {
    func knightPossibleMoves(_ location: LocationIndex, _ color: PieceColor)-> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        var possibleNumberIndex = nidx + 2
        var possibleCharIndex = sidx + 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx + 2
        possibleCharIndex = sidx - 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 2
        possibleCharIndex = sidx + 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 2
        possibleCharIndex = sidx - 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx + 1
        possibleCharIndex = sidx - 2
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 1
        possibleCharIndex = sidx - 2
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx + 1
        possibleCharIndex = sidx + 2
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 1
        possibleCharIndex = sidx + 2
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        return possibleMoves
    }
}
