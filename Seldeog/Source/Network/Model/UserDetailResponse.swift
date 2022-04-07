//
//  UserDetailResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/07.
//

import Foundation

struct UserDetailResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
}
