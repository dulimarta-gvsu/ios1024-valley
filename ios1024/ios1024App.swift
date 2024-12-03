//
//  ios1024App.swift
//  ios1024
//
//  Created by Hans Dulimarta for CIS357
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ios1024App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sharedGameViewModel = GameViewModel()
    @StateObject var navigator = MyNavigator()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(sharedGameViewModel)
                .environmentObject(navigator)
            
        }
    }
}
