//
//  ContentView.swift
//  iExpense
//
//  Created by Ryan on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State var expenses = Expense()
    // showing the add view or nah?
    @State private var showingAddExpense = false
    
    
    var body: some View {
            NavigationStack {
                List {
                    // list all expense items
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                        }
                    }
                    // delete expense item on delete / allows swipe to delete
                    .onDelete(perform: removeItem)
                }
                .navigationTitle("iExpense")
                // to test adding to the list an item
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        // create new expense item
//                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                        expenses.items.append(expense)
                        // make showinf new view true on button click
                        showingAddExpense = true
                    }
                }
                // present a new view
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
        }
    }
    
    // remove an expense item from the array of expenses
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
