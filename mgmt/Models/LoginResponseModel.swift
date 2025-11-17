//
//  LoginResponseModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 17/11/25.
//

import Foundation

struct LoginResponse: Codable {
    let message: String
    let token: String
    let user: APIUser
}
