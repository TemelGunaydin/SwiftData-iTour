//
//  Destination.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    
    //When a destination is deleted, sights will be deleted also
    //Also if we delete sight from the array below(with .inverse),the destination object will be aware of the change.
    @Relationship(deleteRule : .cascade,inverse: \Sight.destination) var sights : [Sight] = []

    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
