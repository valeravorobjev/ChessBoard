//
//  File.swift
//
//
//  Created by Валерий Воробьев on 28.04.2024.
//

import Foundation

//public extension ShadowBoard {
//    func checkmate(possibles: [LocationIndex]) {}
//
//    private func makeShadowBoard() -> any BoardCommon {
//        let shadowBoard: any BoardCommon = BoardDefault(boardMode: boardMode, playerColor: playerColor)
//
//        for i in 0..<8 {
//            for j in 0..<8 {
//                if cells[i][j].piece == nil {
//                    continue
//                }
//                let shadowCell = shadowBoard.cells[i][j]
//                let cell = cells[i][j]
//                shadowCell.setPiece(cell.piece!.type, cell.piece!.color)
//            }
//        }
//
//        return shadowBoard
//    }
//
//    internal func checkKingWhenPiceMove(pieceType: PieceType, location: LocationIndex, possible: LocationIndex) -> Bool {
//        let shadowBoard = makeShadowBoard()
//
//        let kingLocation = shadowBoard.playerColor == .white ? shadowBoard.whiteKingLI : shadowBoard.blackKingLI
//
//        let fromCell = shadowBoard.cells[location.nidx][location.sidx]
//        let toCell = shadowBoard.cells[possible.nidx][possible.sidx]
//
//        let tmp = fromCell.piece!
//
//        fromCell.removePiece()
//        toCell.setPiece(tmp.type, tmp.color)
//
//        for i in 0..<8 {
//            for j in 0..<8 {
//                let cell = shadowBoard.cells[i][j]
//
//                if cell.piece == nil || cell.piece?.color == shadowBoard.playerColor {
//                    continue
//                }
//
//                shadowBoard.changePlayer()
//                let shadowPossibles = shadowBoard.possibleMoves(by: cell.piece!.type, location: convertLCtoLI(cell.location))
//
//                for shadowPossible in shadowPossibles {
//                    if shadowPossible.nidx == kingLocation.nidx && shadowPossible.sidx == kingLocation.sidx {
//                        return true
//                    }
//                }
//
//                shadowBoard.changePlayer()
//            }
//        }
//
//        return false
//    }
//}
