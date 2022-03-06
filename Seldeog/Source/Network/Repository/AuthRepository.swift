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
    
    public func postSignIn(email: String,
                           password: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignIn(email: email, password: password)) { result in
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
    
    public func postSignUp(email: String,
                           password: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignUp(email: email, password: password)) { result in
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
    
    public func checkEmailValid(email: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.checkEmailValid(email: email)) { result in
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
            case 500:
                return .serverErr
            default:
                return .networkFail
            }
        }

}
