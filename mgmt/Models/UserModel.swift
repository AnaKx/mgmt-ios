//
//  UserModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 12/11/25.
//

import Foundation

struct User : Codable, Identifiable, Hashable {
    let id: UUID
    let joinedAt: Date
    let name: String
    let email: String
    
    let isAdmin: Bool
    var hasAccess: Bool
}
