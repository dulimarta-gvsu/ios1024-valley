//
//  AppView.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI

struct AppView: View {
    @StateObject var vm: GameViewModel = GameViewModel()
    @EnvironmentObject var nav: MyNavigator
    
    var body: some View {
        NavigationStack(path: $nav.navPath) {
            LoginView()
                .navigationDestination(for: Destination.self) { d in
                    switch(d) {
                    case .GameScreen: GameView()
                    case .SettingsScreen: SettingsView()
                    case .StatsScreen: StatsView()
                    }
                }
        }
    }
}
