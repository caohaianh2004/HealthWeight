//
//  BackgroundView.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import Foundation
import SwiftUI

extension Text {
    init(localizedkey: String) {
        self.init(LocalizationSystem.sharedInstance.localizedStringForKey(key: localizedkey, comment: ""))
    }
}
