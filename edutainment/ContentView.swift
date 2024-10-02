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
    @State private var int2 = Int.random(in: 2...9)
    @State private var answer = 0
    @State private var score = 0
    
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
                    Button("Start", action: startGame)
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
                        Text("\(chosenMultiplicationTable) x \(int2)")
                    }
                    TextField("Asnwer", value: $answer, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("MultiplicateIT")
            .onSubmit(checkTheAnswer)
            .alert("Game over", isPresented: $showAlert) {
                Button("New game") { }
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func startGame() {
        showQuestions = true
    }
    
    func checkTheAnswer() {
        if questionNr == chosenquestionQty {
            showAlert = true
            showQuestions = false
            questionNr = 0
        }
        
        var equation = chosenMultiplicationTable * int2
        
        answer == equation ? (score += 1) : (score -= 1)
        questionNr += 1
        answer = 0
        int2 = Int.random(in: 2...9)
    }
}


#Preview {
    ContentView()
}
