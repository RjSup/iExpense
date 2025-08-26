//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ryan on 26/08/2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    // ask for a unique number per expense item so its really unique
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
