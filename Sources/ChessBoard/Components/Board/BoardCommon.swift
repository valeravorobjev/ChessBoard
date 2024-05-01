//
//  File.swift
//
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

/// The chessboard protocol. Describes the basic behavior.
public protocol BoardCommon: ObservableObject {
    /// Constructor
    init(boardMode: BoardMode, playerColor: PieceColor)

    /// Init chessboard. Arrange the pieces on the table
    func initBoard() -> Void
    /// Clear chessboard. Remove all pieces
    func clearBoard() -> Void
    /// Change current player. If the player was white, he will turn black on the turn.
    func changePlayer() -> Void
    /// Set board mode: game, analysis
    /// - Parameters:
    ///  - mode: Board mode
    func changeBoardMode(mode: BoardMode) -> Void
    /// Turn the board over
    func rotateBoard() -> Void
    /// Return board's cell by cell location
    ///  - Parameters:
    ///   - location: Cell location
    /// - Returns: Board cell
    func getCell(_ location: LocationCell) -> Cell
    /// Method run when user tap on cell. This is the main processing for board
    /// - Parameters:
    ///  - cell: Board's cell
    /// - Returns:Move report that contains move details. If the function returned nil, then it is impossible to make a move
    func processing(_ cell: Cell) -> MoveReport?
    /// The method allows you to execute the code for the player programmatically.
    /// - Parameters:
    ///  - from: Start coordinate
    ///  - to: Target coordinate
    /// - Returns:Move report that contains move details. If the function returned nil, then it is impossible to make a move
    func makeMove(from: LocationCell, to: LocationCell) -> MoveReport?
    /// Stop game
    func stopGame() -> Void
    /// Continue game
    func continueGame() -> Void

    /// The cells on the chessboard
    var cells: [[Cell]] { get }
    /// Return board numbers count
    var boardNumbersCount: Int { get }
    /// Return board chars count
    var boardCharsCount: Int { get }
}
