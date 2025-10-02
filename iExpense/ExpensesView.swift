//
//  ExpensesView.swift
//  iExpense
//
//  Created by Ryan on 02/10/2025.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        // for each instance if expense
        ForEach(expenses) { item in
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
        .onDelete(perform: removeItem)
    }
    
    // remove an expense item from the array of expenses
    func removeItem(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
    
    // custom init for filtering
    init(type: String?, sortOrder: [SortDescriptor<Expense>]) {
        if let type {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == type
            }, sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }
}
#Preview {
    ExpensesView(type: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: [Expense.self])
}

