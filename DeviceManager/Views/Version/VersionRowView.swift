//
//  VersionRowView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/30.
//

import SwiftHelpers
import SwiftUI

struct VersionRowView: View {
    
    let firmware: DevicesInformation.Firmware
    
    let signed: Bool
    
    var body: some View {
        HStack {
            Text("\(AppDefine.os) \(firmware.version) (\(firmware.buildid))")
            Image(symbols: signed ? .checkmarkSealFill : .xmarkSealFill)
                .foregroundStyle(signed ? .green : .red)
        }
    }
}

#Preview {
    HomeView()
}
