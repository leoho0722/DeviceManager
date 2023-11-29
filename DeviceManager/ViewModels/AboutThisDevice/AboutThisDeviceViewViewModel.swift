//
//  AboutThisDeviceViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/11/29.
//

import SwiftUI

@Observable
final class AboutThisDeviceViewViewModel {
    
    let os = UIDevice.current.systemName
    let version = UIDevice.current.systemVersion
    
    func getCurrentDeviceFirmware() {
        
    }
    
    func getLatestDeviceFirmware() {
        
    }
}
