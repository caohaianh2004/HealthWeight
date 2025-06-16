//
//  BmiCalcuator.swift
//  Health_Weight
//
//  Created by Boss on 16/06/2025.
//

import Foundation

class BmiCalcuator {
    var image: String
    var height: Double
    var weightKg: Double
    var age: Int
    
    init(image: String, height: Double, weightKg: Double, age: Int) {
        self.image = image
        self.height = height
        self.weightKg = weightKg
        self.age = age
    }
}
