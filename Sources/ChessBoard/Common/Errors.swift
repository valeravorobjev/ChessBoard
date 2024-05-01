//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation


public enum BoardErrors: Error {
    case invalidCellCoordinates(coordStr: String, msg: String)
}
