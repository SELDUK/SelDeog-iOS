//
//  UserAPI.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/07.
//

import Moya

enum UserAPI {
    case registerCharacter(name: String, shape: Int, color: Int, feature: Int)
    case getComplimentList(date: String)
}

extension UserAPI: BaseTargetType {

    var path: String {
        switch self {
        case .registerCharacter:
            return "/userDetail"
        case .getComplimentList:
            return "/character"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerCharacter:
            return .post
        case .getComplimentList:
            return .get
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
        case let .getComplimentList(date):
            let parameters = [
                "date": date
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        }
    }

}
