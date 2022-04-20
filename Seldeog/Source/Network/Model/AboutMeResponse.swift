//
//  AboutMeResponse.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/20.
//

import Foundation

struct AboutMeResponse: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: AboutMeData
}

struct AboutMeData: Decodable {
    let usrChrName: String
    let usrChrDicts: [MyFeatures]
}

struct MyFeatures: Decodable {
    let usrChrDictIdx: Int
    let usrChrDictCont: String
    let date: String
}
