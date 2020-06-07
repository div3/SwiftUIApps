//
//  HabitView.swift
//  HabitTracker
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    @State var habit: Habit
    var body: some View {
        NavigationView {
            VStack {
                Text(habit.title)
                Text(habit.description ?? "Nothing")
                Button("Add instance") {
                    
                }
            }
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit(title: "test", description: "desc"))
    }
}
