//
//  ContentView.swift
//  BetterRest
//
//  Created by Divyansh on 6/4/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    private let model = SleepCalculator()
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime


    var body: some View {
        NavigationView {
            
        Form {
            Text("Time you'd like to wake up:")
                    .font(.headline)
            DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            VStack(alignment: .leading, spacing: 0) {
            Text("Desired amount of sleep")
                .font(.headline)

            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            
            }
            
            VStack(alignment: .leading, spacing: 0) {
            Text("Daily coffee intake")
                .font(.headline)

            Stepper(value: $coffeeAmount, in: 1...20) {
                if coffeeAmount == 1 {
                    Text("1 cup")
                } else {
                    Text("\(coffeeAmount) cups")
                }
            }
            }
            Text("\(calculateBedtime())")
        }
            .navigationBarTitle("Better Rest")
    }
    }

    func calculateBedtime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return (formatter.string(from:sleepTime))
        } catch {
            return String("Error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
