//
//  PersonUnits.swift
//  Health_Weight
//
//  Created by Boss on 13/06/2025.
//

import Foundation

struct PersonUnits {
    var heightFt: Double
    var heightln: Double
    var weightLb: Double
    var age: Int
    var taregetWeightLb: Double
    
    init(heightFt: Double, heightln: Double, weightLb: Double, age: Int, taregetWeightLb: Double) {
        self.heightFt = heightFt
        self.heightln = heightln
        self.weightLb = weightLb
        self.age = age
        self.taregetWeightLb = taregetWeightLb
    }
}
