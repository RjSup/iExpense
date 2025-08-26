//
//  Expense.swift
//  iExpense
//
//  Created by Ryan on 26/08/2025.
//

import SwiftUI

@Observable
class Expense {
    // computed property
    // array of expense items called (items)
    var items = [ExpenseItem]() {
        // checks for items added or removed
        didSet {
            // create encoder use it to encode 
            if let encoded = try? JSONEncoder().encode(items) {
                
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
