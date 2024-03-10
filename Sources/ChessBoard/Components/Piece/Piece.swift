//
//  Piece.swift
//  
//
//  Created by Valery Vorobjev on 08.01.2024.
//

import Foundation

/*
 Chess piece
 */
struct Piece {
    var type: PieceType    // Type of piece
    var color: PieceColor  // Color
    
    // Piece image
    var img: String {
        get {
            return "Pieces/\(color.toStr())\(type.rawValue)"
        }
    }
}
