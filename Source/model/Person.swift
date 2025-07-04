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
    var weightLb: Double
    var age: Int
    var targetWeightLb: Double
    var targetWeightKg: Double
    var heightFt: Double
    var heightln: Double
    
    init(id: Int? = nil, image: String, heightCm: Double, weightKg: Double, weightLb: Double, age: Int, targetWeightLb: Double, targetWeightKg: Double, heightFt: Double, heightln: Double) {
        self.id = id
        self.image = image
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.weightLb = weightLb
        self.age = age
        self.targetWeightLb = targetWeightLb
        self.targetWeightKg = targetWeightKg
        self.heightFt = heightFt
        self.heightln = heightln
    }
}
