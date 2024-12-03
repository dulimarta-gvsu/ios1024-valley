//
//  StatsView.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI

struct StatsView: View {
    @StateObject var svm: StatsViewModel = StatsViewModel()
    @EnvironmentObject var nav: MyNavigator
    
    var body: some View {
        VStack {
            Text("Past Game Stats:")
                .padding(.bottom, 10)
                .font(.title2)
            HStack {
                Text("\(svm.stats.count) games played")
                Text("Average Steps: \(svm.getAverageSteps())")
            }
            HStack {
                Text("Sort by:")
                Button("Steps") {
                    svm.sortStats(byDate: false)
                }
                Button("Date") {
                    svm.sortStats(byDate: true)
                }
            }
            .buttonStyle(.borderedProminent)
            List {
                ForEach(svm.stats, id: \.self) { stat in
                    VStack(alignment: .center, spacing: 5) {
                        if stat.won {
                            Text("Won \(String(stat.winScore)) in \(stat.steps) steps")
                            Text("\(stat.dateString) | Board Size: \(stat.boardSize)x\(stat.boardSize)")
                        } else {
                            Text("Lost @ \(String(stat.highScore)) (of \(String(stat.winScore))) in \(stat.steps)")
                            Text("\(stat.dateString) | Board Size: \(stat.boardSize)x\(stat.boardSize)")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(stat.won ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .cornerRadius(10)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            
            Button("Return") {
                nav.navigateBack()
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            Task {
                await svm.getStats()
            }
        }
    }
}

#Preview {
    StatsView()
}
