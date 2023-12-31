//
//  DeviceManager.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

final class DeviceManager: NSObject {
    
    public private(set) var device: DeviceManager.Device
    
    public private(set) var deviceInfo: DevicesInformation
    
    var latestVersion: DeviceManager.Version {
        let latest = getLatestVersion()
        return latest
    }
    
    var currentVersion: DeviceManager.Version {
        let current = getCurrentVersion()
        return current
    }
    
    init(device: DevicesInformation) {
        self.deviceInfo = device
        self.device = .init(name: deviceInfo.name, 
                            identifier: deviceInfo.identifier,
                            type: Device.DeviceType(rawValue: UIDevice.current.model) ?? .unknown)
    }
    
    struct Device {
        
        let name: String
        
        let identifier: String
        
        let type: DeviceType
        
        enum DeviceType: String {
            
            case iPhone = "iPhone"
            
            case iPad = "iPad"
            
            case iPodTouch = "iPod Touch"
            
            case unknown = "Unknown Device"
        }
    }
    
    struct Version {
        
        let device: Device
        
        let os: String
        
        let version: String
        
        let build: String
        
        let signed: Bool
        
        let releaseDate: String
    }
}

private extension DeviceManager {
    
    /// Get device latest version
    ///
    /// - Returns: ``Version``
    func getLatestVersion() -> Version {
        let os = AppDefine.os
        
        if deviceInfo.firmwares.isEmpty {
            return Version(device: self.device,
                           os: os,
                           version: "Unknown",
                           build: "Unknown",
                           signed: false,
                           releaseDate: "Unknown")
        } else {
            let version = deviceInfo.firmwares[0].version
            let build = deviceInfo.firmwares[0].buildid
            let signed = deviceInfo.firmwares[0].signed
            let releaseDate = deviceInfo.firmwares[0].releasedate
            
            return Version(device: self.device,
                           os: os,
                           version: version,
                           build: build,
                           signed: signed,
                           releaseDate: releaseDate)
        }
    }
    
    /// Get device current version
    ///
    /// - Returns: ``Version``
    func getCurrentVersion() -> Version {
        let os = AppDefine.os
        let version = AppDefine.currentVersion
        
        if deviceInfo.firmwares.isEmpty {
            return Version(device: self.device,
                           os: os,
                           version: version,
                           build: "Unknown",
                           signed: false,
                           releaseDate: "Unknown")
        } else {
            var current: DevicesInformation.Firmware?
            deviceInfo.firmwares.forEach { firmware in
                if firmware.version == version {
                    current = firmware
                }
            }
            guard let current else {
                return Version(device: self.device,
                               os: os,
                               version: version,
                               build: "Unknown",
                               signed: false,
                               releaseDate: "Unknown")
            }
            let build = current.buildid
            let signed = current.signed
            let releaseDate = current.releasedate
            
            return Version(device: self.device,
                           os: os,
                           version: version,
                           build: build,
                           signed: signed,
                           releaseDate: releaseDate)
        }
    }
}
