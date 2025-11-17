//
//  LoginViewModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var isLoggedIn: Bool
    @Binding var isAdmin: Bool
    @Binding var hasAccess: Bool
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberLogin = false
    
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var loginError: String = ""
    @State private var hasAttemptedSubmit = false
    
    func validateAll() -> Bool {
        emailError = Validators.email(email) ?? ""
        passwordError = Validators.password(password) ?? ""
        
        return emailError.isEmpty && passwordError.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20){
                Spacer()
                
                Text("Welcome back!")
                    .font(Font.largeTitle.weight(.light))
                    .foregroundColor(.accent)
                
                Text("Log in to continue")
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                Spacer()

                
                CustomInputField(label: "Email", text: $email)
                .textInputAutocapitalization(.never)
                if !emailError.isEmpty {
                    Text(emailError)
                        .padding(.vertical, -60)
                        .font(.caption)
                        .foregroundColor(.red)
                        
                }
                
                CustomInputField(label: "Password", text: $password, isSecure: true)
                if !passwordError.isEmpty {
                    Text(passwordError)
                        .padding(.vertical, -60)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            
                Spacer()

            
                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                Button("Log into my account"){
                    hasAttemptedSubmit = true
                        
                        guard validateAll() else {
                            return
                        }
                    
                    Task {
                            do {

                                let response = try await APIService.login(email: email, password: password)
                                
                                KeychainService.shared.saveToken(response.token)
                                UserDefaultsService.shared.saveUser(response.user)
                        
                                isLoggedIn = true
                                isAdmin = response.user.isAdmin
                                hasAccess = response.user.hasAccess
                                
                                dismiss()
                                
                            } catch {
                                loginError = "Invalid email or password. Please try again."
                            }
                        }
                }
                .buttonStyle(CustomButton())

                
                Button {
                    dismiss()
                } label: {
                    Text("\(Text("Don't have an account?").foregroundColor(.secondary)) \(Text("Sign up").foregroundStyle(.accent))")
                }
            
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
    @Previewable @State var isLoggedIn = false
    @Previewable @State var isAdmin = false
    @Previewable @State var hasAccess = false
    
    LoginView(
        isLoggedIn: $isLoggedIn,
        isAdmin: $isAdmin,
        hasAccess: $hasAccess
    )
}
