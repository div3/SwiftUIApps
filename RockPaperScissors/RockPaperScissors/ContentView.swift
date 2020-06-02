//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Divyansh on 6/1/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let options = ["Rock", "Paper", "Scissors"]
    @State var score = 0
    @State var current_choice = 0
    @State var player_choice = 0
    @State var display_text = "initializing"
    @State var num_tries = 0
    
    var body: some View {
        VStack {
            Text("Let's Play")
            HStack {
             ForEach(0 ..< 3) { number in
                     Button(action: {
                        self.current_choice = self.rps()
                        self.player_choice = number
                        if self.playRound(self.current_choice, self.player_choice) == -1 {
                            self.score += 1
                         }
                        switch(self.playRound(self.current_choice, self.player_choice)) {
                        case 1: self.display_text = ("App won ... sorry!")
                        case 0: self.display_text = ("'twas a draw!")
                        case -1: self.display_text = ("You win... this time!")
                        default:
                            self.display_text = "Beep Bop, this is an error!"
                        }
                        
                     }) {
                         Text(self.options[number])
                         .padding()
                     }
                 }
             }
            Text("Your Score: \(score)")
            Text("You chose: \(options[player_choice]), the app chose: \(options[current_choice])")
            Text(display_text)
        }
    }
    
    func playRound(_ player1:Int, _ player2:Int) -> Int {
        if (player1 == player2) {
            return 0
        } else if ((player1 == 0 && player2 == 2) || (player1 == 1 && player2 == 0) || (player1 == 2 && player2 == 1)) {
            return 1
        } else {
            return -1
        }
    }
    
    func rps () -> Int {
        return Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
