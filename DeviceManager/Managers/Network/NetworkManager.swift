//
//  NetworkManager.swift
//  DeviceManager
//
//  Created by Leo Ho on 2023/10/29.
//

import Foundation

import SwiftHelpers

final class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func requestWith<E, D>(method: HTTP.HTTPMethod,
                           path: String,
                           parameters: E) async throws -> D where E: Encodable, D: Decodable {
        let request = try createURLRequest(method: method, path: path, parameters: parameters)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200 ... 299).contains(httpResponse.statusCode) else {
            throw HTTP.HTTPStatus.badRequest
        }
        
        do {
            let result = try JSONDecoder().decode(D.self, from: data)
            return result
        } catch {
            throw NetworkConstants.NetworkError.jsonDecodedFailed
        }
    }
    
    private func createURLRequest<E>(method: HTTP.HTTPMethod,
                                     path: String,
                                     parameters: E) throws -> URLRequest where E: Encodable {
        let baseURL = NetworkConstants.baseURL
        guard let url = URL(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            HTTP.HTTPHeaderFields.acceptType.rawValue : HTTP.HTTPContentType.json.rawValue
        ]
        
        return request
    }
}

struct NetworkConstants {
    
    static let baseURL = "https://"
    
    enum APIs {
        
        /// - Parameters:
        ///   - identifier: the model name of device
        case getDevices(String)
        
        var endpoints: String {
            switch self {
            case .getDevices(let identifier): "api.ipsw.me/v4/device/\(identifier)"
            }
        }
    }
    
    enum NetworkError: Error {
        
        /// JSON Decode Failed
        case jsonDecodedFailed
    }
}
