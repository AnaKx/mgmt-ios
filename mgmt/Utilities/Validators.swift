//
//  Validators.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 17/11/25.
//

import Foundation

struct Validators {
    
    static func name(_ name: String) -> String? {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Name is required"
        }
        if !name.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
            return "Name can only contain letters"
        }
        return nil
    }
    
    static func email(_ email: String) -> String? {
        if email.isEmpty {
            return "Email is required"
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return "Please enter a valid email"
        }
        return nil
    }
 
    static func password(_ password: String) -> String? {
        if password.isEmpty {
            return "Password is required"
        }
        if password.contains(" ") {
            return "Password cannot contain spaces"
        }
        if password.count < 8 {
            return "Password must be at least 8 characters"
        }
        return nil
    }
}
