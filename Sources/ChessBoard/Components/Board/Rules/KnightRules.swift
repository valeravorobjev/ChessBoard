//
//  KnightRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func knightPossibleMoves(_ location: CLocation, _ color: PColor)-> [CLocation] {
        var possibleMoves = [CLocation]()
        
        let numbers = self.playerColor == .white ? self.boardNumbers : self.boardNumbers.reversed()
        
        let yindex = numbers.firstIndex(of: location.y)!
        let xindex = self.boardChars.firstIndex(of: location.x)!
        
        var possibleYIndex = yindex + 2
        var possibleXIndex = xindex + 1
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex + 2
        possibleXIndex = xindex - 1
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex - 2
        possibleXIndex = xindex + 1
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex - 2
        possibleXIndex = xindex - 1
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex + 1
        possibleXIndex = xindex - 2
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex - 1
        possibleXIndex = xindex - 2
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex + 1
        possibleXIndex = xindex + 2
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        possibleYIndex = yindex - 1
        possibleXIndex = xindex + 2
        
        _ = possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex)
        
        return possibleMoves
    }
}
