//
//  HomeView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            VersionView()
                .navigationTitle("Devices Information")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
