//
//  ContentView.swift
//  edutainment
//
//  Created by Natalia Nikiforuk on 02/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTables = [2, 3, 4, 5, 6, 7, 8, 9]
    @State private var chosenMultiplicationTable = 2
    @State private var questionQty = [5, 10, 20]
    @State private var chosenquestionQty = 5
    @State private var questionNr = 1
    @State private var showQuestions = true
    @State private var showAlert = false
    @State private var answer = 0
    @State private var score = 0
    @State private var questions = [2, 3, 4, 5, 6, 7, 8, 9].shuffled()
    @State private var currentQuestionIndex = 0
    
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Choose multiplication table", selection: $chosenMultiplicationTable) {
                    ForEach(multiplicationTables, id: \.self) {
                        Text("\($0)")
                    }
                }
                Text("How many questions?")
                Picker("", selection: $chosenquestionQty) {
                    ForEach(questionQty, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Spacer()
                    Button("Start") {
                        showQuestions = true
                    }
                        .background(.green)
                        .foregroundStyle(.white)
                        .bold()
                        .buttonStyle(.bordered)
                        .padding()
                    Spacer()
                }
                
                if showQuestions {
                    HStack {
                        Text("Question #\(questionNr):")
                        Spacer()
                        Text("\(questions[currentQuestionIndex]) x \(chosenMultiplicationTable)")
                    }
                    TextField("Asnwer", value: $answer, format: .number)
                }
            }
            .navigationTitle("MultiplicateIT")
            .onSubmit(startGame)
            .alert("Game over", isPresented: $showAlert) {
                Button("New game") { }
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func startGame() {
        if questionNr == chosenquestionQty {
            showAlert = true
            showQuestions = false
            questionNr = 0
        }
        
        checkTheAnswer()
    }
    
    func checkTheAnswer() {
        let equation = chosenMultiplicationTable * questions[currentQuestionIndex]
        
        answer == equation ? (score += 1) : (score -= 1)
        questionNr += 1
        currentQuestionIndex += 1
        questions.shuffle()
        answer = 0
    }
}

#Preview {
    ContentView()
}
