//
//  ContentView.swift
//  WordScramble
//
//  Created by Divyansh on 6/5/20.
//  Copyright © 2020 Div. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView() {
            VStack {
                HStack {
                    Button("New Word", action: startGame)
                        .padding(.leading)
                    Spacer()
                }
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                
                List(usedWords, id:\.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Your score is \(score)")
            }
            .onAppear(perform: startGame)
            .navigationBarTitle(rootWord)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        
    }
    
    func addNewWord() {
        let lower = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if (lower.count == 0) {return}
        
        guard isOriginal(word: lower) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: lower) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: lower) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        usedWords.insert(lower, at: 0)
        score += newWord.count
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        
        guard word.count >= 2 else {
            wordError(title: "Word Length", message: "Words must be two or more characters")
            return false}
        guard word != rootWord else {
            wordError(title: "Using Root word", message: "You can't use the root word.")
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "abattoir"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
