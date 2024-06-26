//
//  File.swift
//
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation

/// Piece move structure whth data about move action
public struct MoveReport {
    /// Old piece coordinate
    var oldLoc: LocationCell
    /// New piece coordinate after move
    var newLoc: LocationCell
    /// The piece that move
    var ownPiece: Piece
    /// The piece that was taken
    var targetPiece: Piece?
    /// Chess UCI format notation
    var uci: String {
        return "\(oldLoc.toStr())\(newLoc.toStr())"
    }

    /// Is the king under the check
    private(set) var checkKing: Bool
    /// Has the king been checkmated
    private(set) var checkMate: Bool

    init(oldLoc: LocationCell, newLoc: LocationCell, ownPiece: Piece, targetPiece: Piece? = nil) {
        self.oldLoc = oldLoc
        self.newLoc = newLoc
        self.ownPiece = ownPiece
        self.targetPiece = targetPiece
        self.checkKing = false
        self.checkMate = false
    }

    init(oldLoc: LocationCell, newLoc: LocationCell, ownPiece: Piece, targetPiece: Piece? = nil, checkKing: Bool, checkMate: Bool) {
        self.oldLoc = oldLoc
        self.newLoc = newLoc
        self.ownPiece = ownPiece
        self.targetPiece = targetPiece
        self.checkKing = checkKing
        self.checkMate = checkMate
    }
}
