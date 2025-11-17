//
//  ApiService.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 16/11/25.
//


import Foundation

class APIService {
    static let baseURL = "https://mgmt-backend-production.up.railway.app"
    
    // Auth Endpoints
    static func signup(name: String, email: String, password: String, isAdmin: Bool) async throws -> SignupResponse {
        let url = URL(string: "\(baseURL)/auth/signup")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "isAdmin": isAdmin
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(SignupResponse.self, from: data)
    }
    
    static func login(email: String, password: String) async throws -> LoginResponse {
        let url = URL(string: "\(baseURL)/auth/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(LoginResponse.self, from: data)
    }
    
    // User endpoints
    static func getAllUsers(token: String) async throws -> [APIUser] {
        let url = URL(string: "\(baseURL)/users")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let usersResponse = try decoder.decode(UsersResponse.self, from: data)
        return usersResponse.users
    }
    
    static func revokeAccess(userId: String, token: String) async throws {
        let url = URL(string: "\(baseURL)/users/\(userId)/revoke")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
    
    static func restoreAccess(userId: String, token: String) async throws {
        let url = URL(string: "\(baseURL)/users/\(userId)/restore")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }

}
