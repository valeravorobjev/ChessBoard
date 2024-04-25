//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

/*
 The chessboard protocol. Describes the basic behavior.
 */
public protocol BoardCommon: BoardCore, ObservableObject {
    
    init(boardMode: BoardMode, playerColor: PieceColor)             // Constructor
    
    func initBoard() -> Void                                        // Init chessboard. Arrange the pieces on the table
    func clearBoard() -> Void                                       // Clear chessboard. Remove all pieces
    func setPlayerColor(color: PieceColor) -> Void                  // Set player color: black or wight
    func setBoardMode(mode: BoardMode) -> Void                      // Set board mode: game, analysis
    func rotateBoard() -> Void                                      // Turn the board over
}
