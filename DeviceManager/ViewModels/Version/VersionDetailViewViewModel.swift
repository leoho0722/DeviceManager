//
//  VersionDetailViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import Foundation

final class VersionDetailViewViewModel {
    
    private var firmware: DevicesInformation.Firmware
    
    var version: Version.Version {
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
    
    /// Use ``DevicesInformation.Firmware`` to initialize ``VersionDetailViewViewModel``
    init(firmware: DevicesInformation.Firmware) {
        self.firmware = firmware
    }
}
