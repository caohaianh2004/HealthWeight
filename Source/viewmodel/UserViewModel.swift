//
//  UserViewModel.swift
//  Health_Weight
//
//  Created by Boss on 13/06/2025.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var people: [Person] = []
    
    func fetchPeople() {
        people = DatabasePeople.shared.getPerson()
    }
}
