//
//  AuthAPI.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/03.
//

import Moya

enum AuthAPI {
    case postSignIn(email: String, password: String)
    case postSignUp(email: String, password: String)
    case checkEmailValid(email: String)
}

extension AuthAPI: BaseTargetType {

    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/login"
        case .postSignUp:
            return "/auth/signup"
        case .checkEmailValid:
            return "/auth/signup/check"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postSignIn, .postSignUp:
            return .post
        case .checkEmailValid:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .postSignIn(email, password):
            let parameters = [
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .postSignUp(email, password):
            let parameters = [
                "email": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .checkEmailValid(email):
            let parameters = [
                "email": email
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

}
