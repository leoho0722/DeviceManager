//
//  VersionDetailView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

import SwiftHelpers

struct VersionDetailView: View {
    
    let firmware: DevicesInformation.Firmware
    
    let os = UIDevice.current.systemName
    
    private var vm: VersionDetailViewViewModel
    
    init(firmware: DevicesInformation.Firmware) {
        self.firmware = firmware
        self.vm = VersionDetailViewViewModel(firmware: firmware)
    }
    
    var body: some View {
        VStack {
            Image(vm.version.icon)
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 30))
                .padding()
            Form {
                Text("Version: " + os + " " + firmware.version + " (\(firmware.buildid))")
                Text("Release Date: \(vm.format(date: firmware.releasedate))")
                HStack {
                    Text("Signed State: \(firmware.signed ? "Signed" : "Unsigned")")
                    Image(systemIcon: firmware.signed ? .checkmarkSealFill : .xmarkSealFill)
                        .foregroundStyle(firmware.signed ? .green : .red)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
