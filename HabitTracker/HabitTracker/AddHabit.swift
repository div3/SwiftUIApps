//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct AddHabit: View {
    @State private var title = ""
    @State private var desc = ""
    @ObservedObject var habits: Habits
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text:$desc)
                Button("Add Habit") {
                    self.saveAndExit()
                }
            }
            .navigationBarTitle("New Habit")
            .navigationBarItems(trailing: Button("Save") {
                self.saveAndExit()
            })
        }
    }
    func saveAndExit() {
        let habit = Habit(title: self.title, description: self.desc)
        self.habits.habits.append(habit)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
