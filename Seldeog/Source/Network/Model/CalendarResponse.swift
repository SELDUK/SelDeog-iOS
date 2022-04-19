//
//  CalendarResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/19.
//

import Foundation

struct CalendarResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserCharacterImages
}

struct UserCharacterImages: Decodable {
    let usrChrImgs: [UserCharacterImage]
}

struct UserCharacterImage: Decodable {
    let usrChrIdx: Int
    let usrChrImg: String
    let usrChrDateCrt: String
}
