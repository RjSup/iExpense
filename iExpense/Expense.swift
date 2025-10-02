//
//  Expense.swift
//  iExpense
//
//  Created by Ryan on 26/08/2025.
//

import SwiftUI
import SwiftData

@Model
class Expense {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
