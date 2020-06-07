//
//  AddExpense.swift
//  iExpense
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct AddExpense: View {
    @State private var name = ""
    @State private var type = "Essential"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Essential", "Optional"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expenses())
    }
}
