//
//  VersionRowView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/30.
//

import SwiftUI

import SwiftHelpers

struct VersionRowView: View {
    
    let firmware: DevicesInformation.Firmware
    
    let signed: Bool
    
    var body: some View {
        HStack {
            Text("\(UIDevice.current.systemName) \(firmware.version) (\(firmware.buildid))")
            Image(systemIcon: signed ? .checkmarkSealFill : .xmarkSealFill)
                .foregroundStyle(signed ? .green : .red)
        }
    }
}

#Preview {
    HomeView()
}
