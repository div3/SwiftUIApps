//
//  ContentView.swift
//  HabitTracker
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {

        NavigationView {
            List {
                ForEach(habits.habits) { habit in
                    Text(habit.title)
                    }
            .onDelete(perform: removeItems)
            }
        .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddHabit) {
                    AddHabit(habits: self.habits)
            }
        }
            
    }
    func removeItems(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
