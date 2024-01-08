//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation

/// Piece move structure whth data about move action
struct MoveReport {
    var oldLoc: CLocation       // Old piece coordinate
    var newLoc: CLocation       // New piece coordinate after move
    var ownPiece: Piece         // The piece that move
    var targetPiece: Piece?     // The piece that was taken
    var uci: String {           // Computed property return UCI string format of move. Example: e2e4
        get {
            return "\(self.oldLoc.toStr())\(self.newLoc.toStr())"
        }
    }
}
