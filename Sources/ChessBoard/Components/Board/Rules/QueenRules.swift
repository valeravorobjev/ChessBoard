//
//  QueenRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension BoardCommon {
    func queenPossibleMoves(_ location: LocationIndex) -> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        var possibleNumberIndex = nidx
        var possibleCharIndex = sidx
        while possibleNumberIndex > -1 {
            possibleNumberIndex -= 1
            possibleCharIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleNumberIndex < 8 {
            possibleNumberIndex += 1
            possibleCharIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleCharIndex < 8 {
            possibleNumberIndex -= 1
            possibleCharIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleCharIndex > -1 {
            possibleNumberIndex += 1
            possibleCharIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        while possibleNumberIndex < 8 {
            possibleNumberIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, sidx, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        while possibleNumberIndex > -1 {
            possibleNumberIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, sidx, possibleNumberIndex) {
                break
            }
        }
        
        possibleCharIndex = sidx
        while possibleCharIndex > -1 {
            possibleCharIndex -= 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, nidx) {
                break
            }
        }
        
        possibleCharIndex = sidx
        while possibleCharIndex < 8 {
            possibleCharIndex += 1
            
            if !possibleMove(numbers: boardNumbers, possibleMoves: &possibleMoves, playerColor, possibleCharIndex, nidx) {
                break
            }
        }
        
        return possibleMoves
    }
}
