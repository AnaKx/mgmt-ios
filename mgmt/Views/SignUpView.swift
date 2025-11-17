//
//  SignUpViewModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isAdmin: Bool
    @Binding var hasAccess: Bool
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberSignup: Bool = false
    @State private var newUserIsAdmin = false
    
    @State private var nameError: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var hasAttemptedSubmit = false


    func validateAll() -> Bool {
        nameError = Validators.name(name) ?? ""
        emailError = Validators.email(email) ?? ""
        passwordError = Validators.password(password) ?? ""
        
        return nameError.isEmpty && emailError.isEmpty && passwordError.isEmpty
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                
                Spacer()
                
                Text("Get started")
                    .font(Font.largeTitle.weight(.light))
                    .foregroundColor(.accent)
                
                Text("Create a new account")
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                CustomInputField(label: "Preferred name", text: $name)
                if !nameError.isEmpty {
                        Text(nameError)
                            .padding(.vertical, -60)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                
                CustomInputField(label: "Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
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
                   

                Toggle(isOn: $newUserIsAdmin) {
                    Text("Give admin access")
                        .foregroundColor(.secondary)
                }
                .modifier(CustomToggle())
                
                Spacer()
                
                Button("Create my account"){
                    hasAttemptedSubmit = true
                        
                        guard validateAll() else {
                            return
                        }
                    
                    Task {
                            do {
                                let response = try await APIService.signup(
                                    name: name,
                                    email: email.lowercased(),
                                    password: password,
                                    isAdmin: newUserIsAdmin
                                )
                                
                                // Update
                                let loginResponse = try await APIService.login(email: email, password: password)
                                KeychainService.shared.saveToken(loginResponse.token)
                                UserDefaultsService.shared.saveUser(loginResponse.user)
                                
                                isLoggedIn = true
                                isAdmin = loginResponse.user.isAdmin
                                hasAccess = loginResponse.user.hasAccess
                                
                            } catch {
                                print("Signup failed:", error)
                                // TODO: Show error to user
                            }
                        }
                    
                }
                .buttonStyle(CustomButton())
                    NavigationLink(destination: LoginView(
                        isLoggedIn: $isLoggedIn,
                        isAdmin: $isAdmin,
                        hasAccess: $hasAccess
                    )) {
                        Text("\(Text("Already have an account?").foregroundColor(.secondary)) \(Text("Log in").foregroundStyle(.accent))")         }
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(.background)
                    .ignoresSafeArea()
            }
        }

    }
    }
    
    #Preview {
        @Previewable @State var isLoggedIn = false
        @Previewable @State var isAdmin = false
        @Previewable @State var hasAccess = false
        
        SignUpView(
                isLoggedIn: $isLoggedIn,
                isAdmin: $isAdmin,
                hasAccess: $hasAccess
            )    }
