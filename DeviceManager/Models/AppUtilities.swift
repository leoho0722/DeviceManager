//
//  AppUtilities.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/12/31.
//

import SwiftHelpers
import UIKit

struct AppUtilities {
    
    /// Format date string
    /// - Parameters:
    ///   - date: date string
    /// - Returns: Formated date string
    static func format(date: String) -> String {
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
    
    enum URLType {
        
        case settings(SystemSettingsURLScheme)
        
        case external(String)
    }
    
    static func openURL(type: URLType) {
        switch type {
        case .settings(let systemSettingsURLScheme):
            if UIApplication.shared.canOpenURL(systemSettingsURLScheme.url) {
                UIApplication.shared.open(systemSettingsURLScheme.url)
            }
        case .external(let string):
            guard let url = URL(string: string) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
