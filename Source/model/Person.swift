//
//  Person.swift
//  Health_Weight
//
//  Created by Boss on 13/06/2025.
//

import Foundation

struct Person: Identifiable {
    var id: Int?
    var image: String
    var heightCm: Double
    var weightKg: Double
    var age: Int
    var targetWeightLb: Double
    
    init( image: String, heightCm: Double, weightKg: Double, age: Int, targetWeightLb: Double) {
       
        self.image = image
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.age = age
        self.targetWeightLb = targetWeightLb
    }
}
