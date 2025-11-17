//
//  SignUpResponseModel.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 17/11/25.
//

import Foundation

struct SignupResponse: Codable {
    let message: String
    let user: APIUser
}
