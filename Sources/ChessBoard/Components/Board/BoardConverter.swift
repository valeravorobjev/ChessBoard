//
//  File.swift
//
//
//  Created by Валерий Воробьев on 30.04.2024.
//

import Foundation

extension ShadowBoard {
    func convertLCtoLI(_ lc: LocationCell) -> LocationIndex {
        let sidx = boardChars.firstIndex(of: lc.char)
        let nidx = boardNumbers.firstIndex(of: lc.number)

        return LocationIndex(sidx: sidx!, nidx: nidx!)
    }

    func convertLItoLC(_ li: LocationIndex) -> LocationCell {
        let char = boardChars[li.sidx]
        let number = boardNumbers[li.nidx]

        return LocationCell(char, number)
    }

    func convertSMRtoMR(_ smr: ShadowMoveReport) -> MoveReport {
        return MoveReport(oldLoc: convertLItoLC(smr.oldLoc), newLoc: convertLItoLC(smr.newLoc), ownPiece: smr.ownPiece, targetPiece: smr.targetPiece, checkKing: smr.checkKing, checkMate: smr.checkMate)
    }
}
