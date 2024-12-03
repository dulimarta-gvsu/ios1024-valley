//
//  StatsViewModel.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI
import FirebaseFirestore

class StatsViewModel: ObservableObject {
    @Published var stats: Array<GameData> = []
    let db = Firestore.firestore()
    
    
    func getStats() async {
        let myStatColl = db.collection("users")
            .document("7aYmy333UKbrg6sfrTcmw8QyRJ02")
            .collection("games")
        
        do {
            let qs = try await myStatColl.getDocuments()
            
            for doc in qs.documents {
                let gStat = try doc.data(as: GameData.self)
                
                await MainActor.run {
                    stats.append(gStat)
                }
            }
        } catch {
            print("Error fetching stats: \(error.localizedDescription)")
        }
    }
    
    func getAverageSteps() -> String {
        var totalSteps = 0
        for stat in stats {
            totalSteps += stat.steps
        }
        
        let average = Double(totalSteps) / Double(stats.count)
        return String(format: "%.2f", average)
    }
    
    func sortStats(byDate: Bool) {
        if (byDate) {
            stats.sort { $0.gameTime > $1.gameTime }
        } else {
            stats.sort { $0.steps < $1.steps }
        }
    }
    
}
