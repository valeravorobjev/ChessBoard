//
//  SwiftUIView.swift
//  
//
//  Created by Валерий Воробьев on 10.03.2024.
//

import SwiftUI

struct BoardPlaygroundView: View {
    
    let board = Board()
    
    var body: some View {
        VStack {
            HStack {
                Button("Init", action: board.initBoard)
                Button("Rotate", action: board.rotateBoard)
                Button("Clear", action: board.clearBoard)
            }
            BoardView(board: board)
        }.padding(100)
    }
}

#Preview {
    BoardPlaygroundView()
}
