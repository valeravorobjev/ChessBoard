//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation

extension PColor {
    func toStr() -> String {
        switch self {
        case .black:
            return "b"
        case .white:
            return "w"
        }
        
    }
    
    func toggle() ->PColor {
        switch self {
        case .black:
            return .white
        case .white:
            return .black
        }
    }
}
