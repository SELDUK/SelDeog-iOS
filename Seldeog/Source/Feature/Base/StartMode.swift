//
//  StartMode.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/14.
//

import UIKit
import Alamofire

enum StartMode: String {
    case onBoarding
    case auth
    case main
}

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case startMode
    }
    
    var startMode: String {
        get { string(forKey: UserDefaultsKeys.startMode.rawValue) ?? StartMode.auth.rawValue}
        set { setValue(newValue, forKey: UserDefaultsKeys.startMode.rawValue)}
    }
}
