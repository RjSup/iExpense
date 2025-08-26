//
//  AddView.swift
//  iExpense
//
//  Created by Ryan on 26/08/2025.
//

import SwiftUI

struct AddView: View {
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    // EXPENSES ARE AN EXPENSE WHICH IS AN ARRAY OF EXPENSE ITEMS
    var expenses: Expense
    
    let types = ["Business", "Personal"]
    
    // allow to dissmiss the view (by enviroment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            // actually add an item to the expense items
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    // dissmiss the view after saving
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expense())
}
