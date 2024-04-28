//
//  SwiftUIView.swift
//
//
//  Created by Валерий Воробьев on 10.03.2024.
//

import SwiftUI

struct BoardPlaygroundView: View {
    let board = BoardDefault()

    var body: some View {
        VStack {
            HStack {
                Button("Init", action: board.initBoard)
                Button("Rotate", action: board.rotateBoard)
                Button("Change Player", action: board.changePlayer)
                Button("Clear", action: board.clearBoard)
                Button("MakeMove") {
                    _ = board.makeMove(from: LocationCell("c", 2), to: LocationCell("c", 4))
                }
            }
            BoardView(board: board)
        }.padding(100)
    }
}

#Preview {
    BoardPlaygroundView()
}
