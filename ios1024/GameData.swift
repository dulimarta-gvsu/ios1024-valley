//
//  GameData.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import FirebaseFirestore

struct GameData: Codable, Hashable {
    @DocumentID var id: String?
    let boardSize: Int
    let gameTime: Date
    let highScore: Int
    let steps: Int
    let winScore: Int
    let won: Bool
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: gameTime)
    }
}
