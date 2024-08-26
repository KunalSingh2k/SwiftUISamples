//
//  ContentView.swift
//  SwiftUIScrambleWords
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    // ID is needed to identify unique strings.
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .toolbar {
                Button("Restart") { startGame() }
            }
            .navigationTitle(rootWord)
            .onSubmit { addNewWord() }
            .onAppear(perform: { startGame() })
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") { }
            }message: {
                Text(alertMessage)
            }
        }
    }
    
    //MARK: - Add New Word Method
    func addNewWord() {
        // lower case and trim the whiteSpaces
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Exit if string is empty
        guard answer.count > 3 else {
            wordError(title: "Error!", message: "Try words that has 3 or more letters")
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original..")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)..")
            return
        }
        guard isReal(word: answer) else { 
            wordError(title: "Word not recognised", message: "I'm afraid, You can't just makem up..")
            return
        }
                
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    //MARK: - Start Game Method
    func startGame() {
        // Find Url of the text file
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Load the contents of file into text
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split the string on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // Pick a random word as rootword or provide default
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        // Triggering a crash and reporting the error
        fatalError("Could not load start.txt file from the bundle")
    }
    
    //MARK: - Is Original method
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    //MARK: - Is possible method
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    
    //MARK: - Is real method
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    //MARK: - Show Error method
    /// uses alert to show the error
    func wordError(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
    #Preview {
        ContentView()
    }
