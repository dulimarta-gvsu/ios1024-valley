//
//  MyNavigator.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI

enum Destination {
    case GameScreen
    case SettingsScreen
    case StatsScreen
}
class MyNavigator: ObservableObject {
    
    @Published var navPath: NavigationPath = NavigationPath()
    
    func navigate(to d: Destination) {
        navPath.append(d)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        while navPath.count > 0 {
            navPath.removeLast()
        }
    }
}
