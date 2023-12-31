//
//  VersionViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import Collections
import SwiftUI

@Observable
final class VersionViewViewModel {
    
    var deviceManager: DeviceManager?
    
    var isSameVersion: Bool {
        guard let currentVersion = Double(AppDefine.currentVersion),
              let latestVersion = Double(deviceManager!.latestVersion.version) else {
            return false
        }
        return latestVersion.isEqual(to: currentVersion)
    }
    
    private var signed: [DevicesInformation.Firmware] = []
    var signedFirmwares: OrderedDictionary<String, [DevicesInformation.Firmware]> = [:]
    
    private var unsigned: [DevicesInformation.Firmware] = []
    var unsignedFirmwares: OrderedDictionary<String, [DevicesInformation.Firmware]> = [:]
    
    func getDevices(identifier: String) async {
        do {
            let request = DevicesInformationRequest()
            let manager = NetworkManager.shared
            let path = NetworkConstants.APIs.getDevices(identifier).endpoints
            let device: DevicesInformationResponse = try await manager.requestWith(method: .get,
                                                                                   path: path,
                                                                                   parameters: request)
            self.deviceManager = DeviceManager(device: device)
            signed = (deviceManager?.deviceInfo.firmwares.filter { $0.signed })!
            signedFirmwares = preProcess(firmwares: signed)
            
            unsigned = (deviceManager?.deviceInfo.firmwares.filter { !$0.signed })!
            unsignedFirmwares = preProcess(firmwares: unsigned)
        } catch {
            print(error)
        }
    }
    
    private func preProcess(firmwares: [DevicesInformation.Firmware]) -> OrderedDictionary<String, [DevicesInformation.Firmware]> {
        let ios12 = firmwares.filter { $0.buildid.prefix(2) == "16" }
        let ios13 = firmwares.filter { $0.buildid.prefix(2) == "17" }
        let ios14 = firmwares.filter { $0.buildid.prefix(2) == "18" }
        let ios15 = firmwares.filter { $0.buildid.prefix(2) == "19" }
        let ios16 = firmwares.filter { $0.buildid.prefix(2) == "20" }
        let ios17 = firmwares.filter { $0.buildid.prefix(2) == "21" }
        
        var versionDict: OrderedDictionary<String, [DevicesInformation.Firmware]> = [:]
        if !ios12.isEmpty {
            versionDict.updateValue(ios12, forKey: "iOS 12")
        }
        if !ios13.isEmpty {
            versionDict.updateValue(ios13, forKey: "iOS 13")
        }
        if !ios14.isEmpty {
            versionDict.updateValue(ios14, forKey: "iOS 14")
        }
        if !ios15.isEmpty {
            versionDict.updateValue(ios15, forKey: "iOS 15")
        }
        if !ios16.isEmpty {
            versionDict.updateValue(ios16, forKey: "iOS 16")
        }
        if !ios17.isEmpty {
            versionDict.updateValue(ios17, forKey: "iOS 17")
        }
        
        return versionDict
    }
}
