//
//  AdminView.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct AdminView: View {
    @Binding var isLoggedIn: Bool
    
    @State private var users: [APIUser] = []
    @State private var selectedUser: APIUser?
    @State private var isLoading = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(Text("You have")) \(Text("admin").foregroundStyle(.accent).fontWeight(.light)) \(Text("access"))")
                .font(Font.largeTitle.weight(.thin))
            
            if isLoading {
                ProgressView("Loading users...")
            } else {
                List(users, id: \.id) { user in
                    HStack {
                        Text(user.name)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        selectedUser = user
                    }
                }
            }
            
            Spacer()
            
            Button("Log out") {
                KeychainService.shared.deleteToken()
                UserDefaultsService.shared.clearUser()
                isLoggedIn = false
            }
            .buttonStyle(CustomButton())
        }
        .sheet(item: $selectedUser) { user in
            UserDetailsView(user: user, onAccessChanged: {Task {
                await fetchUsers()
            }})
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .onAppear {  // Moved .onAppear outside the button!
            Task {
                await fetchUsers()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background {
            Color(.background)
                .ignoresSafeArea()
        }
    }
    
    func fetchUsers() async {  // Moved outside body
        guard let token = KeychainService.shared.getToken() else { return }
        
        do {
            users = try await APIService.getAllUsers(token: token)
            isLoading = false
        } catch {
            print("Failed to fetch users:", error)
            isLoading = false
        }
    }
}

#Preview {
    @Previewable @State var isLoggedIn = true
    
    AdminView(isLoggedIn: $isLoggedIn)
}
