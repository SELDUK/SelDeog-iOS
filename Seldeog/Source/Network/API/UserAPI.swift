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
    case createTodayCharacter(color: Int)
    case getCalendarData(date: String)
    case getAboutMe(order: String)
    case createFeature(content: String)
    case putFeature(usrChrDictIdx: Int, content: String)
    case deleteFeature(usrChrDictIdx: Int)
    case getSelfLove
    case getCalendarButton
}

extension UserAPI: BaseTargetType {

    var path: String {
        switch self {
        case .registerCharacter:
            return "/userDetail"
        case .getComplimentList, .createTodayCharacter:
            return "/character"
        case let .createComment(usrChrIdx,_ ,_ ),
            let .deleteComment(usrChrIdx, _),
            let .putComment(usrChrIdx, _, _, _):
            return "/character/\(usrChrIdx)/comment"
        case .getCalendarData:
            return "/calendar"
        case .getAboutMe, .createFeature, .putFeature, .deleteFeature:
            return "/aboutMe"
        case .getSelfLove:
            return "/selfLove"
        case .getCalendarButton:
            return "/calendar/button"
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerCharacter, .createComment, .createTodayCharacter, .createFeature:
            return .post
        case .getComplimentList, .getCalendarData, .getAboutMe, .getSelfLove, .getCalendarButton:
            return .get
        case .deleteComment, .deleteFeature:
            return .delete
        case .putComment, .putFeature:
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
        case let .createTodayCharacter(color):
            let parameters = [
                "color": color
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .getCalendarData(date):
            let parameters = [
                "date": date
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getAboutMe(order):
            let parameters = [
                "order": order
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .createFeature(content):
            let parameters = [
                "content": content
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .putFeature(usrChrDictIdx, content):
            let parameters = [
                "usrChrDictIdx": usrChrDictIdx,
                "content": content
            ] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .deleteFeature(usrChrDictIdx):
            let parameters = [
                "usrChrDictIdx": usrChrDictIdx
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getSelfLove:
            return .requestPlain
        case .getCalendarButton:
            return .requestPlain
        }
    }

}
