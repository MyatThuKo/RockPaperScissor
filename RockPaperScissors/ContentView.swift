//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Myat Thu Ko on 5/12/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct TitleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size: 45))
    }
}

struct BodyText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size: 25))
    }
}

struct ButtonText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 45))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray, lineWidth: 10)
        )
    }
}


struct ContentView: View {
    
    @State private var moveSelections = ["✊", "✋", "✌️"]
    @State private var userMove = "✊"
    @State private var computerMove = "✊"
    @State private var score = 0
    @State private var gameStatus = "tie"
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [ .black, .black, .red, .red, .black, .black, .black, .red, .red, .black, .black]), center: .center)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                VStack{
                    TitleText(text: "Let's Play")
                    BodyText(text: "Rock, Paper, Scissors")
                }
                Spacer()
                HStack(spacing: 45){
                    ForEach(0..<moveSelections.count) { move in
                        Button(action: {
                            self.playTheGame(user: "\(self.moveSelections[move])")
                        }){
                            ButtonText(text: "\(self.moveSelections[move])")
                        }
                    }
                }
                Spacer()
                VStack{
                    BodyText(text: "You \(gameStatus) the match.")
                    BodyText(text: "You chose \(userMove).")
                    BodyText(text: "Computer chose is \(computerMove).")
                    BodyText(text: "The score is \(score).")
                }
            }
        }
    }
    
    // to check who wins the round
    func playTheGame(user: String) {
        
        computerMove = moveSelections.randomElement()!
        userMove = user
        
        switch (user, computerMove) {
        case ("✊", "✊"):
            gameStatus = "tie"
        case ("✊", "✌️"):
            gameStatus = "win"
        case ("✊", "✋"):
            gameStatus = "lose"
        case ("✌️", "✌️"):
            gameStatus = "tie"
        case ("✌️", "✊"):
            gameStatus = "lose"
        case ("✌️", "✋"):
            gameStatus = "win"
        case ("✋", "✋"):
            gameStatus = "tie"
        case ("✋", "✌️"):
            gameStatus = "lose"
        case ("✋", "✊"):
            gameStatus = "win"
        default:
            gameStatus = ""
        }
        
        // conditions to check the score should add or not
        switch gameStatus {
        case "win":
            score += 1
        case "lose":
            if score == 0 {
                score = 0
            } else {
                score -= 1
            }
        default:
            break
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
