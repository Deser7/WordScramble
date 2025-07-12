//
//  ContentView.swift
//  WordScramble
//
//  Created by Наташа Спиридонова on 11.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var userWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    // MARK: - Computed Properties
    private var currentLanguage: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }
    
    private var wordsFileName: String {
        currentLanguage == "ru" ? "start_ru" : "start"
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField(NSLocalizedString("enter_word", comment: "Placeholder for word input"), text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(userWords, id: \.self) { word in
                        Label(word, systemImage: "\(word.count).circle")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button(NSLocalizedString("ok_button", comment: "OK button text")) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    // MARK: - Game Logic
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(
                title: NSLocalizedString("word_used_already", comment: "Error when word is already used"),
                message: NSLocalizedString("be_more_original", comment: "Message to be more original")
            )
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(
                title: NSLocalizedString("word_not_possible", comment: "Error when word cannot be formed"),
                message: String(format: NSLocalizedString("word_not_possible_message", comment: "Message when word cannot be formed from root word"), rootWord)
            )
            return
        }
        
        guard isReal(word: answer) else {
            wordError(
                title: NSLocalizedString("word_not_recognized", comment: "Error when word is not recognized"),
                message: NSLocalizedString("word_not_recognized_message", comment: "Message when word is not a real word")
            )
            return
        }
        
        withAnimation {
            userWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: wordsFileName, withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: .newlines)
                    .filter { !$0.isEmpty }
                rootWord = allWords.randomElement() ?? NSLocalizedString("default_root_word", comment: "Default root word if file loading fails")
                return
            }
        }
        
        fatalError(NSLocalizedString("could_not_load_file", comment: "Error when start.txt cannot be loaded"))
    }
    
    // MARK: - Validation Methods
    func isOriginal(word: String) -> Bool {
        !userWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let possible = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: possible)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(
            location: 0,
            length: word.utf16.count
        )
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: currentLanguage
        )
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - Helper Methods
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
