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
    var type: PieceType // Type of piece
    var color: PieceColor // Color

    init() {
        self.type = .pown
        self.color = .white
    }

    init(_ type: PieceType, _ color: PieceColor) {
        self.type = type
        self.color = color
    }

    // Piece image
    var img: String {
        return "Pieces/\(color.toStr())\(type.rawValue)"
    }
}
