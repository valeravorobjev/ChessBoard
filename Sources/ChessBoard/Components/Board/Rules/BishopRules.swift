//
//  BishopRules.swift
//  MyChess
//
//  Created by Валерий Воробьев on 07.01.2024.
//

import Foundation

extension ShadowBoard {
    func bishopPossibleMoves(_ location: LocationIndex) -> [LocationIndex] {
        var possibleMoves = [LocationIndex]()
        
        let sidx = location.sidx
        let nidx = location.nidx
        
        var possibleNumberIndex = nidx
        var possibleCharIndex = sidx
        while possibleNumberIndex > -1 {
            possibleNumberIndex -= 1
            possibleCharIndex -= 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleNumberIndex < 8 {
            possibleNumberIndex += 1
            possibleCharIndex += 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleCharIndex < 8 {
            possibleNumberIndex -= 1
            possibleCharIndex += 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        possibleNumberIndex = nidx
        possibleCharIndex = sidx
        while possibleCharIndex > -1 {
            possibleNumberIndex += 1
            possibleCharIndex -= 1
            
            if !possibleMove(possibleMoves: &possibleMoves, possibleCharIndex, possibleNumberIndex) {
                break
            }
        }
        
        return possibleMoves
    }
}
