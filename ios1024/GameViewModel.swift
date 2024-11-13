//
//  GameViewMode.swift
//  ios1024
//
//  Created by Hans Dulimarta for CIS357
//
import SwiftUI
class GameViewModel: ObservableObject {
    @Published var grid: Array<Array<Int>>
    @Published var steps: Int = 0
    @Published var win: Bool = false
    @Published var lose: Bool = false
    
    init () {
        grid = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        let randx = Int.random(in: 0..<4)
        let randy = Int.random(in: 0..<4)
        grid[randx][randy] = 1
    }
    
    func handleSwipe(_ direction: SwipeDirection) {
        switch(direction) {
            case .left:  swipeLeft()
            case .right:  swipeRight()
            case .up:  swipeUp()
            case .down:  swipeDown()
        }
    }
    
    func placeOne() {
        var randx = Int.random(in: 0..<4)
        var randy = Int.random(in: 0..<4)
        while grid[randx][randy] != 0 {
            randx = Int.random(in: 0..<4)
            randy = Int.random(in: 0..<4)
        }
        grid[randx][randy] = 1
    }
    
    func resetGame() {
        grid = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        let randx = Int.random(in: 0..<4)
        let randy = Int.random(in: 0..<4)
        grid[randx][randy] = 1
        steps = 0
        win = false
        lose = false
    }
    
    func checkGameOver() {
        win = checkWin()
        lose = checkLose()
    }
    
    func checkWin() -> Bool {
        for r in 0..<4 {
            for c in 0..<4 {
                if grid[r][c] == 1024 {
                    return true
                }
            }
        }
        return false
    }
    
    func checkLose() -> Bool {
        if !isValidMove(dir: 0) && !isValidMove(dir: 1) && !isValidMove(dir: 2) && !isValidMove(dir: 3) {
            return true
        } else {
            return false
        }
    }
    
    func isValidMove(dir: Int) -> Bool {
        // 0 = left, 1 = up, 2 = right, 3 = down
        switch(dir) {
        case 0: // check for valid swipe left
            for c in 1..<4 {
                for r in 0..<4 {
                    if grid[r][c] != 0 {
                        if grid[r][c - 1] == 0 || grid[r][c - 1] == grid[r][c] {
                            return true
                        }
                    }
                }
            }
            return false
        case 1: // check for valid swipe up
            for c in 0..<4 {
                for r in 1..<4 {
                    if grid[r][c] != 0 {
                        if grid[r - 1][c] == 0 || grid[r - 1][c] == grid[r][c] {
                            return true
                        }
                    }
                }
            }
            return false
        case 2: // check for valid swipe right
            for c in stride(from: 2, through: 0, by: -1) {
                for r in 0..<4 {
                    if grid[r][c] != 0 {
                        if grid[r][c + 1] == 0 || grid[r][c + 1] == grid[r][c] {
                            return true
                        }
                    }
                }
            }
            return false
        case 3: // check for valid swipe down
            for c in 0..<4 {
                for r in 0..<3 {
                    if grid[r][c] != 0 {
                        if grid[r + 1][c] == 0 || grid[r + 1][c] == grid[r][c] {
                            return true
                        }
                    }
                }
            }
            return false
        default:
            print("invalid direction")
            return false
        }
    }
    
    func swipeLeft() {
        if isValidMove(dir: 0) && !win && !lose {
            steps += 1
            for r in 0..<4 {
                var lastMergeCol = -1
                var targetCol = 0
                
                for c in 0..<4 {
                    if grid[r][c] != 0 {
                        if targetCol != c {
                            grid[r][targetCol] = grid[r][c]
                            grid[r][c] = 0
                        }
                        
                        if targetCol > 0 && grid[r][targetCol] == grid[r][targetCol - 1] && targetCol - 1 > lastMergeCol {
                            grid[r][targetCol - 1] *= 2
                            grid[r][targetCol] = 0
                            lastMergeCol = targetCol - 1
                        } else {
                            targetCol += 1
                        }
                    }
                }
            }
            placeOne()
            checkGameOver()
        }
    }
    
    func swipeUp() {
        if isValidMove(dir: 1) && !win && !lose {
            steps += 1
            for c in 0..<4 {
                var lastMergeRow = -1
                var targetRow = 0
                
                for r in 0..<4 {
                    if grid[r][c] != 0 {
                        if targetRow != r {
                            grid[targetRow][c] = grid[r][c]
                            grid[r][c] = 0
                        }
                        
                        if targetRow > 0 && grid[targetRow][c] == grid[targetRow - 1][c] && targetRow - 1 > lastMergeRow {
                            grid[targetRow - 1][c] *= 2
                            grid[targetRow][c] = 0
                            lastMergeRow = targetRow - 1
                        } else {
                            targetRow += 1
                        }
                    }
                }
            }
            placeOne()
            checkGameOver()
        }
    }
    
    func swipeRight() {
        if isValidMove(dir: 2) && !win && !lose {
            steps += 1
            for r in 0..<4 {
                var lastMergeCol = 4
                var targetCol = 3
                
                for c in stride(from: 3, through: 0, by: -1) {
                    if grid[r][c] != 0 {
                        if targetCol != c {
                            grid[r][targetCol] = grid[r][c]
                            grid[r][c] = 0
                        }
                        
                        if targetCol < 3 && grid[r][targetCol] == grid[r][targetCol + 1] && targetCol + 1 < lastMergeCol {
                            grid[r][targetCol + 1] *= 2
                            grid[r][targetCol] = 0
                            lastMergeCol = targetCol + 1
                        } else {
                            targetCol -= 1
                        }
                    }
                }
            }
            placeOne()
            checkGameOver()
        }
    }
    
    func swipeDown() {
        if isValidMove(dir: 3) && !win && !lose {
            steps += 1
            for c in 0..<4 {
                var lastMergeRow = 4
                var targetRow = 3
                
                for r in stride(from: 3, through: 0, by: -1) {
                    if grid[r][c] != 0 {
                        if targetRow != r {
                            grid[targetRow][c] = grid[r][c]
                            grid[r][c] = 0
                        }
                        
                        if targetRow < 3 && grid[targetRow][c] == grid[targetRow + 1][c] && targetRow + 1 < lastMergeRow {
                            grid[targetRow + 1][c] *= 2
                            grid[targetRow][c] = 0
                            lastMergeRow = targetRow + 1
                        } else {
                            targetRow -= 1
                        }
                    }
                }
            }
            placeOne()
            checkGameOver()
        }
    }
}
