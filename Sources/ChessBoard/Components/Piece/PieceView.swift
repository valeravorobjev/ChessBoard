//
//  SwiftUIView.swift
//
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import SwiftUI

struct PieceView: View {
    var piece: Piece
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Image(piece.img, bundle: .module)
            .resizable()
            .frame(width:width, height: height)
        
    }
}

#Preview {
    PieceView(piece: Piece(type: .pown, color: .white), width: 49, height: 49)
        .frame(width: 200, height: 100)
}
