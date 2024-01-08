//
//  QueenRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension Board {
    func queenPossibleMoves(_ location: CLocation, _ color: PColor)-> [CLocation] {
        var possibleMoves = [CLocation]()
        
        let numbers = self.playerColor == .white ? self.boardNumbers : self.boardNumbers.reversed()
        
        let yindex = numbers.firstIndex(of: location.y)!
        let xindex = self.boardChars.firstIndex(of: location.x)!
        
        
        var possibleYIndex = yindex
        var possibleXIndex = xindex
        while possibleYIndex > -1 {
            possibleYIndex -= 1
            possibleXIndex -= 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex) {
                break
            }
                
        }
        
        possibleYIndex = yindex
        possibleXIndex = xindex
        while possibleYIndex < 8 {
            possibleYIndex += 1
            possibleXIndex += 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex) {
                break
            }
        }
        
        possibleYIndex = yindex
        possibleXIndex = xindex
        while possibleXIndex < 8 {
            possibleYIndex -= 1
            possibleXIndex += 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex) {
                break
            }
        }
        
        possibleYIndex = yindex
        possibleXIndex = xindex
        while possibleXIndex > -1 {
            possibleYIndex += 1
            possibleXIndex -= 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, possibleYIndex) {
                break
            }
        }
        
        possibleYIndex = yindex
        while possibleYIndex < 8 {
            possibleYIndex += 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, xindex, possibleYIndex) {
                break
            }
        }
        
        possibleYIndex = yindex
        while possibleYIndex > -1 {
            possibleYIndex -= 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, xindex, possibleYIndex) {
                break
            }
        }
        
        possibleXIndex = xindex
        while possibleXIndex > -1 {
            possibleXIndex -= 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, yindex) {
                break
            }
        }
        
        possibleXIndex = xindex
        while possibleXIndex < 8 {
            possibleXIndex += 1
            
            if !possibleMove(numbers: numbers, possibleMoves: &possibleMoves, color, possibleXIndex, yindex) {
                break
            }
        }
        
        
        return possibleMoves
    }
}
