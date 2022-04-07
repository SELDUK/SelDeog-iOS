//
//  UserAPI.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/07.
//

import Moya

enum UserAPI {
    case registerCharacter(name: String, shape: Int, color: Int, feature: Int)
}

extension UserAPI: BaseTargetType {

    var path: String {
        switch self {
        case .registerCharacter:
            return "/userDetail"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerCharacter:
            return .post
        }
    }
    
    var headers: [String: String]? {
        if let token = UserDefaults.standard.string(forKey: UserDefaultKey.token) {
            return ["Content-Type": "application/json",
                    "token": token]
        } else {
            return ["Content-Type": "application/json"]
        }
    }

    var task: Task {
        switch self {
        case let .registerCharacter(name, shape, color, feature):
            let parameters = [
                "name": name,
                "shape": shape,
                "color": color,
                "feature": feature
            ] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

}
