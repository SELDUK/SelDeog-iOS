//
//  UserRepository.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/07.
//

import Moya

final class UserRepository {

    static let shared = UserRepository()
    private let userProvider = MoyaProvider<UserAPI>()
    
    public func postCharacterInfo(name: String,
                                  shape: Int,
                                  color: Int,
                                  feature: Int,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.registerCharacter(name: name, shape: shape, color: color, feature: feature)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getUserComplimentList(date: String,
                                       completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.getComplimentList(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetComplimentListStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func postComment(usrChrIdx: Int, comment: String, tag: [String],
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.createComment(usrChrIdx: usrChrIdx, comment: comment, tag: tag)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func deleteComment(usrChrIdx: Int, usrChrCmtIdx: Int,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.deleteComment(usrChrIdx: usrChrIdx, usrChrCmtIdx: usrChrCmtIdx)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func putComment(usrChrIdx: Int, usrChrCmtIdx: Int,
                           comment: String, tag: [String],
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.putComment(usrChrIdx: usrChrIdx, usrChrCmtIdx: usrChrCmtIdx, comment: comment, tag: tag)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func createTodayCharacter(color: Int,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.createTodayCharacter(color: color)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getCharacterForCalendar(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.getCalendarData(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetCalendarStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getAboutMe(order: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.getAboutMe(order: order)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetAboutMeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func postFeature(content: String,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.createFeature(content: content)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func deleteFeature(usrChrDictIdx: Int,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.deleteFeature(usrChrDictIdx: usrChrDictIdx)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func putFeature(usrChrDictIdx: Int,
                           content: String,
                            completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.putFeature(usrChrDictIdx: usrChrDictIdx, content: content)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeUserStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getSelfLove(completion: @escaping (NetworkResult<Any>) -> Void) {
        userProvider.request(.getSelfLove) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetSelfLoveStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeUserStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(UserResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 500:
                return .serverErr
            default:
                return .networkFail
            }
        }
    
    private func judgeGetComplimentListStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(ComplimentListResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 400:
                return .dateDoesNotExist
            default:
                return .networkFail
            }
        }
    
    private func judgeGetCalendarStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(CalendarResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 400:
                return .dateDoesNotExist
            default:
                return .networkFail
            }
        }
    
    private func judgeGetAboutMeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(AboutMeResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 400:
                return .serverErr
            default:
                return .networkFail
            }
        }
    
    private func judgeGetSelfLoveStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(SelfLoveResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 400:
                return .serverErr
            default:
                return .networkFail
            }
        }

}
