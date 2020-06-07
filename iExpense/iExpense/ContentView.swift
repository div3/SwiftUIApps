//
//  ContentView.swift
//  iExpense
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var add_view_visible = false

    var body: some View {
        
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }                }
            .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.add_view_visible = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }.sheet(isPresented: $add_view_visible) {
            AddExpense(expenses: self.expenses)
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
