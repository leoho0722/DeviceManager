//
//  AboutThisDeviceView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/11/29.
//

import SwiftUI

struct AboutThisDeviceView: View {
    
    let manager: DeviceManager
    
    @State private var vm = AboutThisDeviceViewViewModel()
    
    private let os = UIDevice.current.systemName
    private let version = UIDevice.current.systemVersion
    @State private var currentVersion: String = ""
    @State private var latestVersion: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(manager.device.name)")
                buildAboutThisDeviceList()
            }
            .navigationTitle("About")
            .onAppear {
                currentVersion = "\(os) \(version)"
                latestVersion = "\(os) \(manager.latestVersion.version)"
            }
        }
    }
}

#Preview {
    HomeView()
}

// MARK: - @ViewBuilder

private extension AboutThisDeviceView {
    
    @ViewBuilder
    func buildAboutThisDeviceList() -> some View {
        List {
            buildVersionSection()
        }
    }
    
    @ViewBuilder
    func buildVersionSection() -> some View {
        Section {
            Text("Current Version：\(currentVersion)")
            Text("Latest Version：\(latestVersion)")
        }
    }
}
