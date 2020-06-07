//
//  Habits.swift
//  HabitTracker
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import Foundation

struct Habit: Identifiable {
    let title: String
    let description: String?
    let id = UUID()
}

class Habits: ObservableObject {
    @Published var habits = [Habit]()
}
