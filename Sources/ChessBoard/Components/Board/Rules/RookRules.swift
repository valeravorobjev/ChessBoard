//
//  RookRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension BoardCommon {
    func rookPossibleMoves(_ location: LocationIndex) -> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let nidx = location.nidx
        let sidx = location.sidx
        
        var possibleNumberIndex = nidx
        while possibleNumberIndex < endNIndex() {
            possibleNumberIndex += 1
            
            if !possibleMove(possibleMoves: &possibleMoves, sidx, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        while possibleNumberIndex > -1 {
            possibleNumberIndex -= 1
            
            if !possibleMove(possibleMoves: &possibleMoves, sidx, possibleNumberIndex) {
                break
            }
        }
        
        var possibleCharIndex = sidx
        while possibleCharIndex > -1 {
            possibleCharIndex -= 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, nidx) {
                break
            }
        }
        
        possibleCharIndex = sidx
        while possibleCharIndex < endSIndex() {
            possibleCharIndex += 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, nidx) {
                break
            }
        }
        
        return possibleMoves
    }
}
