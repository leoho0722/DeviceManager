//
//  VersionViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

@Observable
final class VersionViewViewModel {
    
    var deviceManager: DeviceManager?
    
    var signedFirmwares: [DevicesInformation.Firmware] = []
    
    var unsignedFirmwares: [DevicesInformation.Firmware] = []
    
    func getDevices(identifier: String) async {
        do {
            let request = DevicesInformationRequest()
            let manager = NetworkManager.shared
            let path = NetworkConstants.APIs.getDevices(identifier).endpoints
            let device: DevicesInformationResponse = try await manager.requestWith(method: .get,
                                                                                    path: path,
                                                                                    parameters: request)
            self.deviceManager = DeviceManager(device: device)
            signedFirmwares = (deviceManager?.deviceInfo.firmwares.filter { $0.signed })!
            unsignedFirmwares = (deviceManager?.deviceInfo.firmwares.filter { !$0.signed })!
        } catch {
            print(error)
        }
    }
}
