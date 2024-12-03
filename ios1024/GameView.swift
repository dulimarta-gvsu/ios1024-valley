//
//  ContentView.swift
//  ios1024
//
//  Created by Hans Dulimarta for CIS357
//

import SwiftUI

struct GameView: View {
    @State var swipeDirection: SwipeDirection? = .none
    @EnvironmentObject var viewModel: GameViewModel
    @EnvironmentObject var nav: MyNavigator
    
    var body: some View {
        VStack {
            Text("Welcome to 1024 by Connor!").font(.title2)
            HStack {
                Text("Swipes: \(viewModel.steps)")
                Button("Reset") {
                    viewModel.resetGame()
                }
            }
            NumberGrid(viewModel: viewModel)
                .gesture(DragGesture().onEnded {
                    swipeDirection = determineSwipeDirection($0)
                    viewModel.handleSwipe(swipeDirection!)
                })
                .padding()
                .frame(
                    maxWidth: .infinity
                )
            if viewModel.win {
                Text("You Win!")
            } else if viewModel.lose {
                Text("You Lose")
            }
            HStack {
                Button("Config") {
                    nav.navigate(to: .SettingsScreen)
                }.padding()
                Button("Stats") {
                    nav.navigate(to: .StatsScreen)
                }.padding()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .buttonStyle(.borderedProminent)
        
        VStack {
            Button("Logout") {
                Task {
                    await viewModel.signOut()
                    nav.navigateToRoot()
                }
            }
        }
        .frame(alignment: .bottom)
        .buttonStyle(.borderedProminent)

    }
}

struct NumberGrid: View {
    @ObservedObject var viewModel: GameViewModel
    //let size: Int = 4

    var body: some View {
        VStack(spacing:4) {
            ForEach(0..<viewModel.size, id: \.self) { row in
                HStack (spacing:4) {
                    ForEach(0..<viewModel.size, id: \.self) { column in
                        let cellValue = viewModel.grid[row][column]
                        Text(cellValue == 0 ? "" : "\(cellValue)")
                            .font(.system(size:26))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.4))
    }
}

func determineSwipeDirection(_ swipe: DragGesture.Value) -> SwipeDirection {
    if abs(swipe.translation.width) > abs(swipe.translation.height) {
        return swipe.translation.width < 0 ? .left : .right
    } else {
        return swipe.translation.height < 0 ? .up : .down
    }
}


#Preview {
    GameView()
}
