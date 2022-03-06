//
//  AuthResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/06.
//

import Foundation

struct AuthResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: Token?
}

struct Token: Decodable {
    let token: String
}
