//
//  ContentView.swift
//  swiftui-project2
//
//  Created by Ignacio Cervino on 17/01/2023.
//

import SwiftUI

// Custom View for each flag
struct FlagImage: View {
    var imageFileName: String

    init(_ imageFileName: String) {
        self.imageFileName = imageFileName
    }

    var body: some View {
        Image(imageFileName)
            .renderingMode(.original)
            .flagStyle()

    }
}

// Custom modifier for all the FlagImage
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var currentQuestion = 0
    @State private var endGame = false
    @State private var selectedCountry = ""
    private let totalQuestions = 8

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold)) // largest built-in font size iOS offers
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(userScore) / \(totalQuestions)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            showMessage()
        }
        .alert("Game Ended", isPresented: $endGame) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Final score \(userScore) / \(totalQuestions)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
        }

        selectedCountry = countries[number]
        currentQuestion += 1
        showingScore = true
        if currentQuestion >= totalQuestions {
            endGame = true
        }
    }

    func showMessage() -> some View {
        if scoreTitle == "Correct" {
            return Text("Your score is \(userScore)")
        } else {
            return Text("Your score is \(userScore) \n Wrong! That’s the flag of \(selectedCountry)")
        }
    }

    func askQuestion() {
        if !endGame {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }

    func resetGame() {
        userScore = 0
        currentQuestion = 0
        endGame = false
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func flagStyle() -> some View {
        modifier(Title())
    }
}
