//
//  UserModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 12/11/25.
//

import Foundation

struct APIUser: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let email: String
    let isAdmin: Bool
    var hasAccess: Bool
}

