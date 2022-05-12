//
//  ComplimentListResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/16.
//

import Foundation

struct ComplimentListResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserData
}

struct UserData: Decodable {
    let usrChrIdx: Int
    let usrChrImg: String
    let usrChrName: String
    let usrChrDateCrt: String
    let usrChrCheck: Bool
    let usrChrCmts: [UserCharacterComment]
}

struct UserCharacterComment: Decodable {
    let usrChrCmtIdx: Int
    let usrChrCmt: String
    let usrCmtTags: [String]
}
