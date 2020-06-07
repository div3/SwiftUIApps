//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct Question {
    let left: Int
    let right: Int
    let ans: Int
    let id: String
    init(_ l: Int, _ r: Int) {
        left = l
        right = r
        ans = left * right
        id = String(left) + String(right) + String(ans)
    }
}

struct ContentView: View {
    @State var minVar = 2
    let absMin = 2
    let absMax = 20
    @State var maxVar = 20
    @State var num_questions = 0
    @State var num_questions_i = 0
    
    @State var in_game = false
    @State var current_score = 0
    @State var questions: [Question] = [Question(10, 3)]
    @State var current_question = 0
    @State var current_answer = ""
    
    @State var alert_text = ""
    @State var showing_alert = false
    @State var alert_message = ""
    
    let question_choices = [5, 10, 15, 20]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Stepper(onIncrement: {
                        self.minVar = min(self.minVar + 1, self.maxVar - 1)
                    }, onDecrement: {
                        self.minVar = max(self.minVar - 1, self.absMin)
                    }, label: { Text("Min: \(minVar)") })
                    Stepper(onIncrement: {
                        self.maxVar = min(self.maxVar + 1, self.absMax)
                    }, onDecrement: {
                        self.maxVar = max(self.maxVar - 1, self.minVar + 1)
                    }, label: { Text("Max: \(maxVar)") })
                }
                VStack(alignment: .leading) {
                    Text("Num Questions")
                    Picker("", selection: $num_questions_i) {
                        ForEach(0..<question_choices.count) {
                            Text(String(self.question_choices[$0]))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Button("Generate") {
                    if (self.in_game) {
                        // Alert, are you sure?
                        self.showing_alert = true
                        self.alert_text = "Game already in Progress"
                        self.alert_message = "Doing this will restart it"
                        return
                    } else {
                        self.start_game()
                    }
                }
                .frame(width: 100, height: 30, alignment: .center)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(3)
                .alert(isPresented: $showing_alert, content: {
                    Alert(title: Text(self.alert_text), message: Text(self.alert_message), primaryButton: .default(Text("Back")), secondaryButton: .default(Text("Continue")) {
                        self.start_game()
                        })
                })
                VStack {
                    HStack {
                        Text("Question: \(current_question)/\(questions.count)")
                            .font(.headline)
                        Spacer()
                        Text("Your Score: \(current_score)")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text(String(questions[current_question].left))
                        Text("x")
                        Text(String(questions[current_question].right))
                        }.padding()
                    .font(.title)
                    TextField("Answer", text: $current_answer)
                        .keyboardType(.numberPad)
                    HStack {
                        Button("Next") {
                            if let ch = (Int(self.current_answer)) {
                                if (ch == self.questions[self.current_question].ans) {
                                    self.current_score += 1
                                }
                                self.next_question()
                            } else {
                                print("Enter a number")
                            }
                        }
                    }
                }.padding()
                Spacer()

                
            }.padding()
            .navigationBarTitle("Multiply!")
        }.edgesIgnoringSafeArea(.all)
    }
    func start_game() {
        self.questions = []
        self.generate_questions()
        self.current_question = 0
        self.current_score = 0
        self.in_game = true
    }
    
    func next_question() {
        if (self.current_question+1 < self.questions.count) {
            self.current_question += 1
            self.current_answer = ""
        } else {
            self.alert_message = "Your score is \(current_score), Press Continue to Play again"
            self.alert_text = "Game over"
            self.showing_alert = true
        }

    }
    func generate_questions() {
        num_questions = question_choices[num_questions_i]
        var num_generated = 0
        let num_possible = min(num_questions, (maxVar - minVar) * 10)
        while(num_generated < num_possible) {
            questions.append(new_question())
            num_generated += 1
        }
    }
    
    func new_question()-> Question {
        let l = Int.random(in: minVar...maxVar)
        let r = Int.random(in: 2...9)
        return Question(l, r)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
