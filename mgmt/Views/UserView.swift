//
//  UserView.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct UserView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(spacing: 20){
            
            Spacer()
            
            Text("\(Text("You have")) \(Text("user").foregroundStyle(.accent).fontWeight(.light)) \(Text("access")) ")
                .font(Font.largeTitle.weight(.thin))
            
            Spacer()
            // list of behind the scenes features
            VStack(alignment: .leading, spacing: 30){
                UserLabel(icon: "lock.shield.fill",
                          text: "Your password is secured with industry-standard Argon2 hashing")

                UserLabel(icon: "key.fill",
                          text: "You get fast, protected access with JWT authentication")

                UserLabel(icon: "lock.icloud.fill",
                          text: "Your sensitive data stays safe with Apple’s Secure Keychain")

                UserLabel(icon: "network",
                          text: "Every connection is protected with full HTTPS encryption")

                UserLabel(icon: "person.badge.shield.checkmark.fill",
                          text: "Only the right people see the right data with role-based access control")

                UserLabel(icon: "cylinder.fill",
                          text: "Your info lives on a reliable, enterprise-grade PostgreSQL database")

                UserLabel(icon: "cloud.fill",
                          text: "All your data runs on secure, globally-distributed Railway cloud hosting")

                UserLabel(icon: "checkmark.shield.fill",
                          text: "Your actions are checked and validated to keep your account safe")
            }

            Spacer()
            
            Button("Log out"){
                KeychainService.shared.deleteToken()
                UserDefaultsService.shared.clearUser()
                
                isLoggedIn = false
            }
            .buttonStyle(CustomButton())
            
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    @Previewable @State var isLoggedIn: Bool = true
    
    UserView(
        isLoggedIn: $isLoggedIn
    )
}
