//
//  BoardView.swift
//  MyChess
//
//  Created by Валерий Воробьев on 03.01.2024.
//

import SwiftUI

public struct BoardView: View {
    @ObservedObject var board: Board
    
    public var body: some View {
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<8) { x in
                    GridRow {
                        ForEach(0..<8) { y in
                            let coord = board.cellCoord(x, y)
                            let cell = board.cells[coord]!
                            CellView(cell: cell, onSelected: {
                                board.selectCell(cell: cell)
                            })
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.width)
        }.scaledToFit()
    }
}

#Preview {
    BoardView(board: Board())
}
