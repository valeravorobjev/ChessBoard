//
//  CCoord.swift
//
//
//  Created by Valery Vorobjev on 08.01.2024.
//

import Foundation

// Cell coord. Example a4
public struct LocationCell {
    init(_ char: Character, _ number: Int) {
        self.char = char
        self.number = number
    }

    var char: Character // Letter designation of a coordinate
    var number: Int // Number designation of a coordinate
}
