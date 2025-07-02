//
//  Utils.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import Foundation


func saveTabState(key: String, value: Bool) {
    UserDefaults.standard.set(value, forKey: key)
}

func loadTabState(key: String) -> Bool {
    UserDefaults.standard.bool(forKey: key)
}
