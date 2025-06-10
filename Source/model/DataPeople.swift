//
//  DataPeople.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import Foundation

struct DataPeople {
    var id: Int?
    var name: String
    var image: String
    var age: Int
    var weightKg: Double
    var weightLb: Double
    var heightCm: Double
    var heightFt: Double
    var heightln: Double
    var targetWeightKg: Double
    var targetWeightLb: Double
    var isMale: Int
    var isUSUnit: Int
    
    init(id: Int? = nil, name: String, image: String, age: Int, weightKg: Double, weightLb: Double, heightCm: Double, heightFt: Double, heightln: Double, targetWeightKg: Double, targetWeightLb: Double, isMale: Int, isUSUnit: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.age = age
        self.weightKg = weightKg
        self.weightLb = weightLb
        self.heightCm = heightCm
        self.heightFt = heightFt
        self.heightln = heightln
        self.targetWeightKg = targetWeightKg
        self.targetWeightLb = targetWeightLb
        self.isMale = isMale
        self.isUSUnit = isUSUnit
    }
}
