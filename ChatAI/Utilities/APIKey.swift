//
//  BundleDataService.swift
//  ChatAI
//
//  Created by CJ on 4/29/24.
//

import Foundation

enum APIKey {
    static var `default`: String {
        do {
            return try BundleDataService.retrieveData(from: Constant.BundleData.resourceFile, basedOn: Constant.BundleData.apiKey)
        } catch {
            fatalError("Error loading default API Key: \(error.localizedDescription)")
        }
    }
}

struct BundleDataService {
    
    static func retrieveData(from resourceFile: String, basedOn key: String) throws -> String {
        guard let path = Bundle.main.path(forResource: resourceFile, ofType: "plist") else {
            throw BundleDataServiceError.missingFile(resourceFile)
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let plist = try PropertyListDecoder().decode([String: String].self, from: data)
            
            guard let value = plist[key], !value.isEmpty else {
                throw BundleDataServiceError.missingURL
            }
            
            guard !value.starts(with: "_") else {
                throw BundleDataServiceError.invalidURL
            }
            
            return value
        } catch {
            throw BundleDataServiceError.decodingError(error)
        }
    }
}

enum BundleDataServiceError: Error {
    case missingFile(String)
    case missingURL
    case invalidURL
    case decodingError(Error)
}

extension BundleDataServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingFile(let file):
            NSLocalizedString("Missing \(file).", comment: "missingFile")
        case .missingURL:
            NSLocalizedString("Missing API address.", comment: "missingURL")
        case .invalidURL:
            NSLocalizedString("Invalid API address.", comment: "invalidURL")
        case .decodingError(let error):
            NSLocalizedString("\(error)", comment: "decodingError")
        }
    }
}
