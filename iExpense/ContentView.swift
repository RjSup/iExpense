//
//  ContentView.swift
//  iExpense
//
//  Created by Ryan on 13/08/2025.
//

import SwiftUI
import SwiftData

// filter all expense options
private enum ExpenseFilter: CaseIterable {
    // possible options
    case personal, business, all

    // instance of option currently in self
    var next: ExpenseFilter {
        switch self {
        case .all:
            return .personal
        case .personal:
            return .business
        case .business:
            return .all
        }
    }

    // instance of option currently in self made into string to repersent it
    var buttonTitle: String {
        switch self {
        case .all: 
            return "Show Personal"
        case .personal: 
            return "Show Business"
        case .business: 
            return "Show All"
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // showing the add view or nah?
    @State private var showingAddExpense: Bool = false

    // init filter to property all
    @State private var filter: ExpenseFilter = .all
    
    // custom sortOrder for sorting options
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]

    var body: some View {
        NavigationStack {
            List {
                // Show all instances of the expenses using the expense view
                // depending on what was picked/filtered by picker show those details in the view
                ExpensesView(type: filter == .all ? nil : (filter == .personal ? "Personal" : "Business"), sortOrder: sortOrder)
                // delete expense item on delete / allows swipe to delete
            }
            .navigationTitle("iExpense")
            // to test adding to the list an item
            .toolbar {
                // add new expense
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
                // filter type of information to show
                Button(filter.buttonTitle) {
                    filter = filter.next
                }
                // picker to choose what to sort expenses by
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                // name on top
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        
                        Text("Sort by amount")
                            .tag([
                                // amount on top
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
            }
            // presents the view to add a new expense
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
    }
}
}

#Preview {
    ContentView()
        .modelContainer(for: Expense.self, inMemory: true)
}
