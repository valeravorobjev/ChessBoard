//
//  KingRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func kingPossibleMoves(_ location: LocationIndex, _ color: PieceColor)-> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        var possibleNumberIndex = nidx + 1
        var possibleCharIndex = sidx + 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx + 1
        possibleCharIndex = sidx - 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 1
        possibleCharIndex = sidx + 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 1
        possibleCharIndex = sidx - 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx - 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx + 1
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx + 1
        possibleCharIndex = sidx
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        possibleNumberIndex = nidx - 1
        possibleCharIndex = sidx
        
        _ = possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, color, possibleCharIndex, possibleNumberIndex)
        
        return possibleMoves
    }
}
