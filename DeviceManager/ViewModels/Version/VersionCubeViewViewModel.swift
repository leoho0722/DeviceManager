//
//  VersionCubeViewViewModel.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/12/31.
//

import Foundation

final class VersionCubeViewViewModel {
    
    var latestVersion: String {
        return manager.latestVersion.version
    }
    
    var isSameVersion: Bool {
        guard let currentVersion = Double(AppDefine.currentVersion),
              let latestVersion = Double(latestVersion) else {
            return false
        }
        return latestVersion.isEqual(to: currentVersion)
    }
    
    let display: Version.Display
    
    private var manager: DeviceManager
    
    /// Use ``DeviceManager`` to initialize ``VersionCubeViewViewModel``
    init(manager: DeviceManager, display: Version.Display) {
        self.manager = manager
        self.display = display
    }
}
