//
//  mgmtApp.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

@main
struct mgmtApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @State private var isLoggedIn = false
    @State private var isAdmin = false
    @State private var hasAccess = false
    
    
    var body: some View {
        Group {
            if !isLoggedIn {
                SignUpView(
                    isLoggedIn: $isLoggedIn,
                    isAdmin: $isAdmin,
                    hasAccess: $hasAccess
                )
            } else if !hasAccess {
                DeniedAccessView(isLoggedIn: $isLoggedIn)
            } else if isAdmin {
                AdminView(isLoggedIn: $isLoggedIn)
            } else {
                UserView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            if let token = KeychainService.shared.getToken(),
               let user = UserDefaultsService.shared.getUser() {
                isLoggedIn = true
                isAdmin = user.isAdmin
                hasAccess = user.hasAccess
            }
        }
    }
}
