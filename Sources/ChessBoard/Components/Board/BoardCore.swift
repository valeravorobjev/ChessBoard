//
//  File.swift
//
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

public protocol BoardCore {
    var cells: [[Cell]] { get } // The cells on the chessboard
    var rotated: Bool { get } // Determines whether the field is rotated or not
    var playerColor: PieceColor { get } // Player color

    var boardNumbers: [Int] { get } // Board's numbers
    var boardChars: [Character] { get } // Board's chars
    var boardMode: BoardMode { get } // Game mode (game or analysis)
}
