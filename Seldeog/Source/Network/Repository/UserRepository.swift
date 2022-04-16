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
                
                let networkResult = self.judgePostCharacterInfoStatus(by: statusCode, data)
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

    
    private func judgePostCharacterInfoStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

            let decoder = JSONDecoder()

            switch statusCode {
            case 200..<300:
                guard let decodedData = try? decoder.decode(UserDetailResponse.self, from: data) else {
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
                return .serverErr
            default:
                return .networkFail
            }
        }
}
