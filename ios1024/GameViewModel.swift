//
//  GameViewMode.swift
//  ios1024
//
//  Created by Hans Dulimarta for CIS357
//
import SwiftUI
class GameViewModel: ObservableObject {
    @Published var grid: Array<Array<Int>>
    init () {
        grid = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    }
    
    func handleSwipe(_ direction: SwipeDirection) {
        let fillValue = switch(direction) {
        case .left:  1
        case .right:  2
        case .up:  3
        case .down:  4
        }
        
        for r in 0 ..< grid.count {
            for c in 0 ..< grid[r].count {
                grid[r][c] = fillValue
            }
        }
    }
}
