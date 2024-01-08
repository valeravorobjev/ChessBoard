//
//  File.swift
//  
//
//  Created by Валерий Воробьев on 08.01.2024.
//

import Foundation
import SwiftUI

class Cell: Identifiable, ObservableObject {
    
    var id: String {location.toStr()}
    var location: CLocation = CLocation(x: "a", y: 1)
    var locationShow: LShow = LShow(xshow: true, yshow: true)
    
    var locationdWhiteColor: Color = Color(red:240/255.0, green:217/255.0, blue:181/255.0)
    var locationBlackColor: Color = Color(red:148/255.0, green:111/255.0, blue:81/255.0)
    
    var cellBlackColor: Color = Color(red: 181/255.0, green: 136/255.0, blue: 99/255.0)
    var cellWhiteColor: Color = Color(red: 240/255.0, green: 217/255.0, blue: 181/255.0 )
    
    @Published var selected: Bool = false
    @Published var possible: Bool = false
    @Published var color: PColor
    @Published private(set) var piece: Piece?
    
    init(color: PColor) {
        self.color = color
    }
    
    init(color: PColor, scoord: String, show: LShow = LShow(xshow: false, yshow: false) ) {
        
        let x = scoord.first!
        let y = Int(String(scoord.last!))!
        
        self.color = color
        self.location = CLocation(x: x, y: y)
        self.locationShow = show
    }
    
    func setPiece(_ type: TPiece, _ color: PColor) {
        self.piece = Piece(type: type, color: color)
    }
    
    func removePiece() {
        self.piece = nil
    }
    
    func xoffset(_ size: CGFloat)-> CGFloat {
        return (size / 2 - (size * 0.10)) * -1
    }
    
    func yoffset(_ size: CGFloat)-> CGFloat {
        return size / 2 - (size * 0.10)
    }
}
