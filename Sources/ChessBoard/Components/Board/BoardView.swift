//
//  BoardView.swift
//  MyChess
//
//  Created by Валерий Воробьев on 03.01.2024.
//

import SwiftUI

public struct BoardView<T: BoardCommon>: View {
    @ObservedObject public var board: T

    public init() {
        self.board = BoardDefault() as! T
    }

    public init(board: T) {
        self.board = board
    }

    public var body: some View {
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<board.boardNumbers.count, id: \.self) { i in
                    GridRow {
                        ForEach(0..<board.boardChars.count, id: \.self) { j in
                            CellView(cell: board.cells[i][j], onSelected: {
                                board.processing(board.cells[i][j])
                            })
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.width)
        }.scaledToFit()
    }
}

#Preview {
    BoardView(board: BoardDefault()).padding(100)
}
