//
//  NetworkResult.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/03.
//

enum NetworkResult<T> {
  case success(T)
  case requestErr(T)
  case pathErr
  case networkFail
}
