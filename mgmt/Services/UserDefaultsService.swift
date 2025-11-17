//
//  UserDefaultsService.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 16/11/25.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    // Keys
    private let userIdKey = "userId"
    private let isAdminKey = "isAdmin"
    private let hasAccessKey = "hasAccess"
    private let nameKey = "userName"
    private let emailKey = "userEmail"
    
    // Save user data
    func saveUser(_ user: APIUser) {
        defaults.set(user.id, forKey: userIdKey)
        defaults.set(user.isAdmin, forKey: isAdminKey)
        defaults.set(user.hasAccess, forKey: hasAccessKey)
        defaults.set(user.name, forKey: nameKey)
        defaults.set(user.email, forKey: emailKey)
    }
    
    // Get user data
    func getUser() -> APIUser? {
        guard let id = defaults.string(forKey: userIdKey),
              let name = defaults.string(forKey: nameKey),
              let email = defaults.string(forKey: emailKey) else {
            return nil
        }
        
        let isAdmin = defaults.bool(forKey: isAdminKey)
        let hasAccess = defaults.bool(forKey: hasAccessKey)
        
        return APIUser(id: id, name: name, email: email, isAdmin: isAdmin, hasAccess: hasAccess)
    }
    
    // Logout
    func clearUser() {
        defaults.removeObject(forKey: userIdKey)
        defaults.removeObject(forKey: isAdminKey)
        defaults.removeObject(forKey: hasAccessKey)
        defaults.removeObject(forKey: nameKey)
        defaults.removeObject(forKey: emailKey)
    }
}
