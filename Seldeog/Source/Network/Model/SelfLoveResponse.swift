//
//  SelfLoveResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/22.
//

import Foundation

struct SelfLoveResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserSelfLove?
}

struct UserSelfLove: Decodable {
    let usrChrName: String
    let usrChrLove: Float
}
