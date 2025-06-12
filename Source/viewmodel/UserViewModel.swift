//
//  UerViewModel.swift
//  Health_Weight
//
//  Created by Boss on 12/06/2025.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var data: [DataPeople] = []
    @Published var userModel: UserModel? = nil
    
    func fetchData() {
        data = DatabasePeople.shared.getPeople()
    }
    
    func addData(_ datapeople: DataPeople) {
        DatabasePeople.shared.insertPeople(dataPeople: datapeople)
        fetchData()
    }
    
    func updateUserInfo(gender: String, height: Double, weight: Double, age: Int, goalWeight: Double) {
        userModel = UserModel(gender: gender, height: height, weight: weight, age: age, goalWeight: goalWeight)
    }

    
//    func deleteData(at offset: IndexSet) {
//        for index in offset {
//            let id = data[index].id
//            Databasedata.shared.deleteData(id: id)
//        }
//        fetchData()
//    }
}

struct UserModel {
    var gender: String
    var height: Double
    var weight: Double
    var age: Int
    var goalWeight: Double
    
    init(gender: String, height: Double, weight: Double, age: Int, goalWeight: Double) {
        self.gender = gender
        self.height = height
        self.weight = weight
        self.age = age
        self.goalWeight = goalWeight
    }
}
