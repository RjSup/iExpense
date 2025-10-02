//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ryan on 13/08/2025.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self, inMemory: true)
    }
}
