//
//  DevicesInformation.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import Foundation

struct DevicesInformationRequest: Codable {}

struct DevicesInformationResponse: Decodable {
    
    let name: String
    
    let identifier: String
    
    let firmwares: [Firmware]
    
    struct Firmware: Decodable {
        
        let identifier: String
        
        let version: String
        
        let buildid: String
        
        let sha1sum: String
        
        let md5sum: String
        
        let sha256sum: String
        
        let filesize: Int
        
        let url: String
        
        let releasedate: String
        
        let uploaddate: String
        
        let signed: Bool
    }
}

typealias DevicesInformation = DevicesInformationResponse
