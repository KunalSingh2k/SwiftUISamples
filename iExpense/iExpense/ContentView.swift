//
//  ContentView.swift
//  iExpense
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expense()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) { AddExpense(expenses: expenses) }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
    }
    
    //MARK: - RemoveItem method
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}

#Preview {
    ContentView()
}
