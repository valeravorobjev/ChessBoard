//
//  LocationIndex.swift
//
//
//  Created by Valery Vorobjev on 15.03.2024.
//

import Foundation

// Piece's location n and s indexes of board array. Start with 0 , end with 7 for 8x8 board
public struct LocationIndex {
    var sidx: Int // Index of board chars
    var nidx: Int // Index of board numbers
}

extension LocationIndex: Equatable {
    public static func == (lhs: LocationIndex, rhs: LocationIndex) -> Bool {
        return lhs.sidx == rhs.sidx && lhs.nidx == rhs.nidx
    }
}
