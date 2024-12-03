//
//  SettingsView.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @EnvironmentObject var nav: MyNavigator
    
    @State private var size: String = "4"
    
    @State private var winScores: [String] = ["64", "128", "256", "512", "1024", "2048", "4096", "8192"]
    @State private var selectedWinScore: String = "1024"
    
    @State private var Error: String = ""
        
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title2)
            TextField("Board Size", text: $size)
                .padding()
                .keyboardType(.numberPad)
                .frame(maxWidth: 200)
            
            Picker("Winning Score", selection: $selectedWinScore) {
                ForEach(winScores, id: \.self) {
                    winScore in Text(winScore)
                }
            }
        }
        .onAppear {
            size = String(viewModel.size)
            selectedWinScore = String(viewModel.winScore)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(maxHeight: .infinity, alignment: .top)
        .buttonStyle(.borderedProminent)
        Text(Error)
        VStack {
            HStack {
                Button("Return") {
                    nav.navigateBack()
                }.padding()
                Button("Update") {
                    if let intSize = Int(size), let intWinScore = Int(selectedWinScore) {
                        if (intSize < 9) {
                            viewModel.updateSettings(newSize: intSize, newWinScore: intWinScore)
                            nav.navigateBack()
                        } else {
                            Error = "Max Board Size is 8"
                        }
                    } else {
                        Error = "Invalid Input"
                    }
                }.padding()
            }
        }
        .frame( alignment: .bottom)
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

#Preview {
    SettingsView()
}
