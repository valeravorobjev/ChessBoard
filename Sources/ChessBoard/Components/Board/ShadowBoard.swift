//
//  File.swift
//
//
//  Created by Валерий Воробьев on 29.04.2024.
//

import Foundation

class ShadowBoard {
    private(set) var playerColor: PieceColor = .white
    private(set) var boardMode: BoardMode = .game
    private(set) var rotated: Bool = false
    private(set) var boardNumbers: [Int] = [8, 7, 6, 5, 4, 3, 2, 1]
    private(set) var boardChars: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    private(set) var whiteKingLI: LocationIndex = .init(sidx: 4, nidx: 7)
    private(set) var blackKingLI: LocationIndex = .init(sidx: 4, nidx: 0)

    private(set) var board: [[Piece?]]

    init(playerColor: PieceColor, boardMode: BoardMode) {
        self.playerColor = playerColor
        self.boardMode = boardMode

        board = Array(repeating: Array(repeating: nil, count: boardNumbers.count), count: boardChars.count)
    }

    init(playerColor: PieceColor, boardMode: BoardMode, boardNumbers: [Int], boardChars: [Character]) {
        self.playerColor = playerColor
        self.boardMode = boardMode
        self.boardNumbers = boardNumbers
        self.boardChars = boardChars

        board = Array(repeating: Array(repeating: nil, count: boardNumbers.count), count: boardChars.count)
    }

    func isCheck(color: PieceColor) -> Bool {
        return false
    }

    func isCheckmate(color: PieceColor) -> Bool {
        return false
    }

    func setWhiteKingLI(_ location: LocationIndex) -> Void {
        whiteKingLI = location
    }

    func setBlackKingLI(_ location: LocationIndex) -> Void {
        blackKingLI = location
    }

    func rotate() {
        for i in 0..<boardNumbers.count / 2 {
            for j in 0..<boardChars.count {
                let tmp = board[boardNumbers.count - (i + 1)][j]
                board[boardNumbers.count - (i + 1)][j] = board[i][j]
                board[i][j] = tmp
            }
        }

        boardNumbers.reverse()
        boardChars.reverse()

        rotated = !rotated

        findKingIndexes()
    }

    func clear() {
        board = Array(repeating: Array(repeating: nil, count: boardNumbers.count), count: boardChars.count)
    }

    func createBoard8x8() {
        let numberIndex0W = boardNumbers.firstIndex(of: boardNumbers.min()!)!
        let numberIndex1W = boardNumbers.firstIndex(of: boardNumbers.min()! + 1)!
        let numberIndex7B = boardNumbers.firstIndex(of: boardNumbers.max()!)!
        let numberIndex6B = boardNumbers.firstIndex(of: boardNumbers.max()! - 1)!

        board[numberIndex0W][0] = Piece(.rook, .white)
        board[numberIndex0W][1] = Piece(.knight, .white)
        board[numberIndex0W][2] = Piece(.bishop, .white)
        board[numberIndex0W][3] = Piece(.queen, .white)
        board[numberIndex0W][4] = Piece(.king, .white)
        board[numberIndex0W][5] = Piece(.bishop, .white)
        board[numberIndex0W][6] = Piece(.knight, .white)
        board[numberIndex0W][7] = Piece(.rook, .white)

        board[numberIndex1W][0] = Piece(.pown, .white)
        board[numberIndex1W][1] = Piece(.pown, .white)
        board[numberIndex1W][2] = Piece(.pown, .white)
        board[numberIndex1W][3] = Piece(.pown, .white)
        board[numberIndex1W][4] = Piece(.pown, .white)
        board[numberIndex1W][5] = Piece(.pown, .white)
        board[numberIndex1W][6] = Piece(.pown, .white)
        board[numberIndex1W][7] = Piece(.pown, .white)

        board[numberIndex7B][0] = Piece(.rook, .black)
        board[numberIndex7B][1] = Piece(.knight, .black)
        board[numberIndex7B][2] = Piece(.bishop, .black)
        board[numberIndex7B][3] = Piece(.queen, .black)
        board[numberIndex7B][4] = Piece(.king, .black)
        board[numberIndex7B][5] = Piece(.bishop, .black)
        board[numberIndex7B][6] = Piece(.knight, .black)
        board[numberIndex7B][7] = Piece(.rook, .black)

        board[numberIndex6B][0] = Piece(.pown, .black)
        board[numberIndex6B][1] = Piece(.pown, .black)
        board[numberIndex6B][2] = Piece(.pown, .black)
        board[numberIndex6B][3] = Piece(.pown, .black)
        board[numberIndex6B][4] = Piece(.pown, .black)
        board[numberIndex6B][5] = Piece(.pown, .black)
        board[numberIndex6B][6] = Piece(.pown, .black)
        board[numberIndex6B][7] = Piece(.pown, .black)

        whiteKingLI = LocationIndex(sidx: 4, nidx: 7)
        blackKingLI = LocationIndex(sidx: 4, nidx: 0)
    }

    func findKingIndexes() {
        for i in 0..<boardNumbers.count {
            for j in 0..<boardChars.count {
                if board[i][j]?.type == .king {
                    if board[i][j]?.color == .white {
                        whiteKingLI = LocationIndex(sidx: j, nidx: i)
                    } else {
                        blackKingLI = LocationIndex(sidx: j, nidx: i)
                    }
                }
            }
        }
    }

    func checkPieceOperationType(location: LocationIndex, possibles: [LocationIndex]) -> PieceOperationType {
        if possibles.count > 0 {
            let selectPossible = possibles.first(where: { $0 == location })

            if selectPossible != nil {
                return PieceOperationType.Move
            }
        }

        let piece = board[location.nidx][location.sidx]

        if piece == nil || piece?.color != playerColor {
            return PieceOperationType.Unknown
        }

        return PieceOperationType.Select
    }

    func move(from: LocationIndex, to: LocationIndex) -> ShadowMoveReport {
        let report = ShadowMoveReport(oldLoc: from, newLoc: to, ownPiece: board[from.nidx][from.sidx]!, targetPiece: board[to.nidx][to.sidx])

        board[to.nidx][to.sidx] = board[from.nidx][from.sidx]

        if board[to.nidx][to.sidx]!.type == .king {
            if board[to.nidx][to.sidx]!.color == .white {
                whiteKingLI = to
            } else {
                blackKingLI = to
            }
        }

        // TODO: add check king and check mate

        return report
    }
}