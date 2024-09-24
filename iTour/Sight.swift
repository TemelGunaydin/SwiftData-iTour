//
//  Sight.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import SwiftData

@Model
class Sight {
    var name : String
    var destination : Destination?
    
    init(name: String) {
        self.name = name
    }
}
