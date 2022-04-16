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
    case createComment(usrChrIdx: Int, comment: String, tag: [String])
    case deleteComment(usrChrIdx: Int, usrChrCmtIdx: Int)
    case putComment(usrChrIdx: Int, usrChrCmtIdx: Int, comment: String, tag: [String])
}

extension UserAPI: BaseTargetType {

    var path: String {
        switch self {
        case .registerCharacter:
            return "/userDetail"
        case .getComplimentList:
            return "/character"
        case let .createComment(usrChrIdx,_ ,_ ),
            let .deleteComment(usrChrIdx, _),
            let .putComment(usrChrIdx, _, _, _):
            return "/character/\(usrChrIdx)/comment"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerCharacter, .createComment:
            return .post
        case .getComplimentList:
            return .get
        case .deleteComment:
            return .delete
        case .putComment:
            return .put
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
        case let .createComment(_, comment, tag):
            let parameters = [
                "comment": comment,
                "tag": tag
            ] as [String: Any]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .deleteComment(_, usrChrCmtIdx):
            let parameters = [
                "usrChrCmtIdx": usrChrCmtIdx
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .putComment(_, usrChrCmtIdx, comment, tag):
            let parameters = [
                "usrChrCmtIdx": usrChrCmtIdx,
                "comment": comment,
                "tag": tag
            ] as [String: Any]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

}
