//
//  SwiftUIView.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import SwiftUI

struct CellView: View {
    @ObservedObject var cell: Cell
    
    var onSelected: ()-> Void = {}
    
    let selectedCellColor = Color(red:106/255.0, green:111/255.0, blue:64/255.0)
    let possibleCellColor = Color(red:106/255.0, green:111/255.0, blue:64/255.0)
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle().fill(cell.color == .black ? cell.cellBlackColor : cell.cellWhiteColor)
                
                if cell.selected {
                    Rectangle()
                        .fill(selectedCellColor)
                        .opacity(0.8)
                }
                
                if cell.locationShow.xshow {
                    Text(String(cell.location.x))
                        .foregroundColor(cell.color == .black ? cell.locationdWhiteColor : cell.locationdWhiteColor)
                        .font(.system(size: (geometry.size.width + geometry.size.height) * 0.10))
                        .offset(
                            x: cell.xoffset(geometry.size.width),
                            y: cell.yoffset(geometry.size.height)
                        )
                }
                
                if cell.locationShow.yshow {
                    Text(String(cell.location.y))
                        .foregroundColor(cell.color == .black ? cell.locationdWhiteColor : cell.locationBlackColor)
                        .font(.system(size: (geometry.size.width + geometry.size.height) * 0.10))
                        .offset(
                            x: cell.xoffset(geometry.size.width),
                            y: cell.xoffset(geometry.size.height)
                        )
                }
                
                if cell.piece != nil {
                    PieceView(piece: cell.piece!, width: geometry.size.width - geometry.size.width * 0.04, height: geometry.size.height - geometry.size.height * 0.04)
                }
                
                if cell.possible {
                    Ellipse().fill(possibleCellColor)
                        .opacity(0.8)
                        .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                }
            }.onTapGesture {
                onSelected()
            }
        }
    }
}

#Preview {
    CellView(cell: Cell(color: .black))
        .frame(width: 200, height: 300)
}
