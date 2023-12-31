//
//  AppDefine.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/12/31.
//

import UIKit

struct AppDefine {
    
    static var os: String {
        return UIDevice.current.systemName
    }
    
    static var currentVersion: String {
        return UIDevice.current.systemVersion
    }
}
