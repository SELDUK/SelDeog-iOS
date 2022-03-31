//
//  AuthAPI.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/03.
//

import Moya

enum AuthAPI {
    case postSignIn(id: String, password: String)
    case postSignUp(id: String, password: String)
    case checkIDValid(id: String)
}

extension AuthAPI: BaseTargetType {

    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/login"
        case .postSignUp:
            return "/auth/signup"
        case .checkIDValid:
            return "/auth/signup/check"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postSignIn, .postSignUp:
            return .post
        case .checkIDValid:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .postSignIn(id, password):
            let parameters = [
                "id": id,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .postSignUp(id, password):
            let parameters = [
                "id": id,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .checkIDValid(id):
            let parameters = [
                "id": id
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

}
