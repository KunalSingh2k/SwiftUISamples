//
//  User.swift
//  iExpense
//
//  Created by Kunal Kumar R on 21/08/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense {
    var items = [ExpenseItem]() {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encodedData, forKey: "items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
