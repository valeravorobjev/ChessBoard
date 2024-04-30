//
//  File.swift
//
//
//  Created by Валерий Воробьев on 30.04.2024.
//

import Foundation

public struct ShadowMoveReport {
    /// Old piece coordinate
    var oldLoc: LocationIndex
    /// New piece coordinate after move
    var newLoc: LocationIndex
    /// The piece that move
    var ownPiece: Piece
    /// The piece that was taken
    var targetPiece: Piece?

    /// Is the king under the check
    private(set) var checkKing: Bool
    /// Has the king been checkmated
    private(set) var checkMate: Bool

    init(oldLoc: LocationIndex, newLoc: LocationIndex, ownPiece: Piece, targetPiece: Piece? = nil) {
        self.oldLoc = oldLoc
        self.newLoc = newLoc
        self.ownPiece = ownPiece
        self.targetPiece = targetPiece
        self.checkKing = false
        self.checkMate = false
    }

    init(oldLoc: LocationIndex, newLoc: LocationIndex, ownPiece: Piece, targetPiece: Piece? = nil, checkKing: Bool, checkMate: Bool) {
        self.oldLoc = oldLoc
        self.newLoc = newLoc
        self.ownPiece = ownPiece
        self.targetPiece = targetPiece
        self.checkKing = checkKing
        self.checkMate = checkMate
    }
}
