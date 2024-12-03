//
//  LoginView.swift
//  ios1024
//
//  Created by Connor Valley on 12/2/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var nav: MyNavigator
    @EnvironmentObject var vm: GameViewModel
    @State var loginError: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login to IOS 1024 Game").font(.title2)
            TextField("Email", text: $email)
                .padding()
                .disableAutocorrection(true)
                .textContentType(.emailAddress)
            SecureField("Password", text: $password)
                .padding()
                .disableAutocorrection(true)
                .textContentType(.password)
            if loginError.count > 0 {
                Text(loginError)
            }
            Button("Login") {
                checkAuthentication()
            }
        }
        .buttonStyle(.borderedProminent)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    func checkAuthentication() {
        Task {
            if await vm.checkUserAcct(email: email, pwd: password) {
                nav.navigate(to: .GameScreen)
            } else {
                loginError = "Invalid Login"
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(GameViewModel())
        .environmentObject(MyNavigator())
}
