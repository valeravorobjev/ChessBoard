//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

protocol BoardMove {
    func move(from: LocationCell, to: LocationCell) -> MoveReport   // Move piece
}
