//
//  VersionView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import Collections
import SwiftHelpers
import SwiftUI

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
            await vm.getDevices(identifier: "iPhone15,5")
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
            VStack {
                Text("\(manager.device.name)")
                    .font(.bold(.title)())
                
                HStack {
                    VersionCubeView(display: .current, manager: manager)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VersionCubeView(display: .latest, manager: manager)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                if !vm.isSameVersion {
                    VStack {
                        Label("Currently it is not the latest version of the system",
                              symbols: .exclamationmarkTriangleFill)
                        .foregroundStyle(.red)
                        
                        Button("Go to update") {
                            AppUtilities.openURL(type: .settings(.softwareUpdate))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        } header: {
            Text("About this device")
        }
    }
    
    @ViewBuilder
    func buildVersionSection(firmwares: OrderedDictionary<String, [DevicesInformation.Firmware]>,
                             signed: Bool) -> some View {
        Section(signed ? "Signed Version" : "Unsigned Version") {
            ForEach(firmwares.keys, id: \.self) { version in
                DisclosureGroup(version) {
                    ForEach(firmwares[version]!, id: \.buildid) { firmware in
                        NavigationLink {
                            VersionDetailView(firmware: firmware)
                        } label: {
                            VersionRowView(firmware: firmware, signed: signed)
                        }
                    }
                }
            }
        }
    }
}
