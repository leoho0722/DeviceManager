//
//  Version.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/12/31.
//

import Foundation

struct Version {
    
    enum Display: String {
        
        case current = "Current"
        
        case latest = "Latest"
    }
    
    enum Version {
        
        /// Unknown iOS Version
        case unknown
        
        /// iOS 12
        case iOS12
        
        /// iOS 13
        case iOS13
        
        /// iOS 14
        case iOS14
        
        /// iOS 15
        case iOS15
        
        /// iOS 16
        case iOS16
        
        /// iOS 17
        case iOS17
        
        var icon: String {
            switch self {
            case .unknown: ""
            case .iOS12: "iOS 12"
            case .iOS13: "iOS 13"
            case .iOS14: "iOS 14"
            case .iOS15: "iOS 15"
            case .iOS16: "iOS 16"
            case .iOS17: "iOS 17"
            }
        }
    }
}
