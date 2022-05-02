//
//  AuthRepository.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/03.
//

import Moya

final class AuthRepository {

    static let shared = AuthRepository()
    private let authProvider = MoyaProvider<AuthAPI>()
    
    public func postSignIn(id: String,
                           password: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignIn(id: id, password: password)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeSignInStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func postSignUp(id: String,
                           password: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignUp(id: id, password: password)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func checkIDValid(id: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.checkIDValid(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 400..<405:
                guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                    return .pathErr
                }
                return .characterDoesNotExist(decodedData)
            case 500:
                return .serverErr
            default:
                return .networkFail
            }
        }
    
    private func judgeSignInStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 210:
                guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                    return .pathErr
                }
                return .characterDoesNotExist(decodedData)
            case 200, 211:
                guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData)
            case 500:
                return .serverErr
            default:
                return .networkFail
            }
        }

}
