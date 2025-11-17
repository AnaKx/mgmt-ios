//
//  UserDetailsView.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct UserDetailsView: View {
    @State var user: APIUser
    
    let onAccessChanged: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Text(user.name)
                .font(Font.largeTitle.weight(.thin))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 40) {
                UserLabel(icon: "person.text.rectangle.fill", text: user.id)
                UserLabel(icon: "envelope.fill", text: user.email)
                UserLabel(icon: user.hasAccess ? "checkmark.circle.fill" : "xmark.circle.fill", text: user.hasAccess ? "This user has access" : "This user has no access")
  
            }

            
            Spacer()
            
            Button(user.hasAccess ? "Revoke access" : "Restore access") {
                Task {
                    guard let token = KeychainService.shared.getToken() else { return }
                    
                    do {
                        if user.hasAccess {
                            try await APIService.revokeAccess(userId: user.id, token: token)
                            user.hasAccess = false
                        } else {
                            try await APIService.restoreAccess(userId: user.id, token: token)
                            user.hasAccess = true
                        }
                        
                        onAccessChanged()
                    } catch {
                        print("Failed to update access:", error)
                    }
                }
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
    UserDetailsView(user: APIUser(
        id: "123",
        name: "Test User",
        email: "test@example.com",
        isAdmin: false,
        hasAccess: true
    ),
            onAccessChanged: {}
    )
}
