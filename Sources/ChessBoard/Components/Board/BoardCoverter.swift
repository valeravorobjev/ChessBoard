//
//  File.swift
//
//
//  Created by Валерий Воробьев on 25.04.2024.
//

import Foundation

extension BoardCommon {
    /// Convert LocationCell to LocationIndex. That is, for example convert 'a4' coordinates to array indexes
    /// - Parameters:
    ///  - lc: Location cell
    /// - Returns: Location index
    func convertLCtoLI(_ lc: LocationCell) -> LocationIndex {
        let sidx = boardChars.firstIndex(of: lc.char)
        let nidx = boardNumbers.firstIndex(of: lc.number)

        return LocationIndex(sidx: sidx!, nidx: nidx!)
    }
}
