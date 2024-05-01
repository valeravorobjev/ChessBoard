//
//  BoardView.swift
//  MyChess
//
//  Created by Валерий Воробьев on 03.01.2024.
//

import SwiftUI

public struct BoardView<T: BoardCommon>: View {
    @ObservedObject public var board: T
    private let moveReportEvent: ((_ moveReport: MoveReport?) -> Void)?

    public init() {
        board = BoardDefault() as! T
        moveReportEvent = nil
    }

    public init(board: T, moveReportEvent: ((_ moveReport: MoveReport?) -> Void)? = nil) {
        self.board = board
        self.moveReportEvent = moveReportEvent
    }

    public var body: some View {
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<board.boardNumbersCount, id: \.self) { i in
                    GridRow {
                        ForEach(0..<board.boardCharsCount, id: \.self) { j in
                            CellView(cell: board.cells[i][j], onSelected: {
                                let moveReport = board.processing(board.cells[i][j])
                                if moveReportEvent != nil {
                                    moveReportEvent!(moveReport)
                                }
                            })
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.width)
        }.scaledToFit()
    }
}

#Preview {
    BoardView(board: BoardDefault(), moveReportEvent: { moveReport in
        print("\(moveReport?.uci)")
    }).padding(100)
}
