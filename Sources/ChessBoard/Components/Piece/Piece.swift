//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation

struct Piece: Identifiable {
    var id: UUID = UUID()
    var type: TPiece
    var color: PColor
    
    var img: String {
        get {
            return "Pieces/\(color.toStr())\(type.rawValue)"
        }
    }
}
