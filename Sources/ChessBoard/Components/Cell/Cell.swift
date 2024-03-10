//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation
import SwiftUI


class Cell: Identifiable, ObservableObject {
    
    public var id: String {location.toStr()}
    var location: LocationCell = LocationCell(char: "a", number: 1)
    var locationShow: LocationShow = LocationShow(charShow: true, numberShow: true)
    
    var locationdWhiteColor: Color = Color(red:240/255.0, green:217/255.0, blue:181/255.0)
    var locationBlackColor: Color = Color(red:148/255.0, green:111/255.0, blue:81/255.0)
    
    var cellBlackColor: Color = Color(red: 181/255.0, green: 136/255.0, blue: 99/255.0)
    var cellWhiteColor: Color = Color(red: 240/255.0, green: 217/255.0, blue: 181/255.0 )
    
    @Published var selected: Bool = false
    @Published var possible: Bool = false
    @Published var color: PieceColor
    @Published private(set) var piece: Piece?
    
    init(color: PieceColor) {
        self.color = color
    }
    
    init(color: PieceColor, location: LocationCell, show: LocationShow = LocationShow(charShow: false, numberShow: false) ) {
        self.color = color
        self.location = location
        self.locationShow = show
    }
    
    func setPiece(_ type: PieceType, _ color: PieceColor) {
        self.piece = Piece(type: type, color: color)
    }

    
    func removePiece() {
        self.piece = nil
    }
    
    func unpossible() {
        self.possible = false
    }
    
    func unselected() {
        self.selected = false
    }
    
    func xoffset(_ size: CGFloat)-> CGFloat {
        return (size / 2 - (size * 0.10)) * -1
    }
    
    func yoffset(_ size: CGFloat)-> CGFloat {
        return size / 2 - (size * 0.10)
    }
}
