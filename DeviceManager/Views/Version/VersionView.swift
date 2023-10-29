//
//  VersionView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

import SwiftHelpers

struct VersionView: View {
    
    @State private var vm = VersionViewViewModel()
    
    var body: some View {
        VStack {
            if let deviceManager = vm.deviceManager {
                List {
                    // About this device Section
                    buildAboutThisDeviceSection(manager: deviceManager)
                    
                    // Signed Version Section
                    buildVersionSection(firmwares: vm.signedFirmwares, signed: true)
                    
                    // Unsigned Version Section
                    buildVersionSection(firmwares: vm.unsignedFirmwares, signed: false)
                }
            } else {
                ContentUnavailableView("Can't get device information!",
                                       systemImage: SFSymbols.xmarkCircleFill.rawValue)
            }
        }
        .task {
            await vm.getDevices(identifier: "iPhone12,8")
        }
    }
}

#Preview {
    HomeView()
}

// MARK: - @ViewBuilder

private extension VersionView {
    
    @ViewBuilder
    func buildAboutThisDeviceSection(manager: DeviceManager) -> some View {
        Section {
            NavigationLink {
                Text("\(manager.device.name)")
            } label: {
                Text("\(manager.device.name)")
            }
            
        } header: {
            Text("About this device")
        }
    }
    
    @ViewBuilder
    func buildVersionSection(firmwares: [DevicesInformation.Firmware], signed: Bool) -> some View {
        Section(signed ? "Signed Version" : "Unsigned Version") {
            ForEach(firmwares, id: \.buildid) { firmware in
                NavigationLink {
                    VersionDetailView(firmware: firmware)
                } label: {
                    VersionRowView(firmware: firmware, signed: signed)
                }
            }
        }
    }
}
