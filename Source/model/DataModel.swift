//
//  datamodel.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import Foundation
struct DataModel {
    var id: Int?
    var time: String
    var weight: Double
    var weight_lb: Double
    
    init(id: Int, time: String, weight: Double, weight_lb: Double) {
        self.id = id
        self.time = time
        self.weight = weight
        self.weight_lb = weight_lb
    }
}
