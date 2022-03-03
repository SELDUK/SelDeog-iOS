//
//  BaseTargetType.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/03.
//

import Moya

public protocol BaseTargetType: TargetType { }

public extension BaseTargetType {

    var baseURL: URL {
        return URL(string: "https://")!
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }

}
