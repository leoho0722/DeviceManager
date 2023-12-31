//
//  VersionCubeView.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/12/31.
//

import SwiftUI

struct VersionCubeView: View {
    
    private var vm: VersionCubeViewViewModel
    
    init(display: Version.Display, manager: DeviceManager) {
        self.vm = VersionCubeViewViewModel(manager: manager, display: display)
    }
    
    var body: some View {
        ZStack {
            switch vm.display {
            case .current:
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20),
                                 style: .continuous)
                .frame(width: 100, height: 100)
                .foregroundStyle(vm.isSameVersion ? .green : .yellow)
            case .latest:
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20),
                                 style: .continuous)
                .frame(width: 100, height: 100)
                .foregroundStyle(.green)
            }
            
            VStack {
                Text(vm.display.rawValue)
                    .font(.bold(.title2)())
                    .padding(.bottom, 5)
                switch vm.display {
                case .current:
                    Text("\(AppDefine.os) \(AppDefine.currentVersion)")
                        .font(.bold(.title3)())
                case .latest:
                    Text("\(AppDefine.os) \(vm.latestVersion)")
                        .font(.bold(.title3)())
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
