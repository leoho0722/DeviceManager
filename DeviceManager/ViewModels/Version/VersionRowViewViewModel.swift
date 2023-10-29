//
//  VersionRowViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

class VersionRowViewViewModel {
    
    private var firmware: DevicesInformation.Firmware
    
    var version: Version {
        if firmware.buildid.hasPrefix("21") {
            // iOS 17
            return .iOS17
        } else if firmware.buildid.hasPrefix("20") {
            // iOS 16
            return .iOS16
        } else if firmware.buildid.hasPrefix("19") {
            // iOS 15
            return .iOS15
        } else if firmware.buildid.hasPrefix("18") {
            // iOS 14
            return .iOS14
        } else if firmware.buildid.hasPrefix("17") {
            // iOS 13
            return .iOS13
        } else if firmware.buildid.hasPrefix("16") {
            // iOS 12
            return .iOS12
        } else {
            // Unknown iOS Version
            return .unknown
        }
    }
    
    /// Use ``DevicesInformation.Firmware`` to initialize ``VersionRowViewViewModel``
    init(firmware: DevicesInformation.Firmware) {
        self.firmware = firmware
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
    
    /// Format date string
    /// - Parameters:
    ///   - date: date string
    /// - Returns: Formated date string
    func format(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = inputFormatter.date(from: date) ?? Date()
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy/MM/dd"
        outputFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        outputFormatter.timeZone = .autoupdatingCurrent
        let dateStr = outputFormatter.string(from: date)
        return dateStr
    }
}
